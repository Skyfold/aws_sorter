with GNAT.Sockets;
with common_types; use common_types;
with Ada.Text_IO;
with Ada.Containers.Vectors;

procedure server is
   ----------------------
   -- Socket Variables --
   ----------------------
   Server_Socket  : GNAT.Sockets.Socket_Type;
   Server_Address : GNAT.Sockets.Sock_Addr_Type;
   Client_Socket  : GNAT.Sockets.Socket_Type;
   Client_Address : GNAT.Sockets.Sock_Addr_Type;

   -----------------------------------------------------
   -- Protected Put_Line for use by the Client_Task's --
   -----------------------------------------------------
   protected Protected_Put is
      procedure Protected_Put_Line (S : String);
   end Protected_Put;

   protected body Protected_Put is
      procedure Protected_Put_Line (S : String) is begin Ada.Text_IO.Put_Line (S); end Protected_Put_Line;
   end Protected_Put;

   ------------------------
   -- Define Client_Task --
   ------------------------
   task type Client_Task is
      entry Enter_Client_Info (Client_Socket_in : in GNAT.Sockets.Socket_Type;
                               Client_Number_in : in Positive);
   end Client_Task;
   type Client_Task_p is access all Client_Task;

   task body Client_Task is
      Client_Socket : GNAT.Sockets.Socket_Type;
      Client_Stream : GNAT.Sockets.Stream_Access;
      Client_Number : Positive;
      Swap_String   : Bounded_300.Bounded_String;
   begin
      -- Get the Socket to talk to the client
      accept Enter_Client_Info (Client_Socket_in : in GNAT.Sockets.Socket_Type;
                                Client_Number_in : in Positive) do
         Client_Socket := Client_Socket_in;
         Client_Number := Client_Number_in;
      end Enter_Client_Info;

      -- Convert the Socket into a Stream
      Client_Stream := GNAT.Sockets.Stream (Client_Socket);

      -- Tell the client their number
      Positive'Write (Client_Stream, Client_Number);

      -- Continually get Strings. Stop on empty string.
      loop
         Bounded_300.Bounded_String'Read (Client_Stream, Swap_String);
         exit when Bounded_300.Length (Swap_String) = 0;
         Protected_Put.Protected_Put_Line ("Client" & Positive'Image (Client_Number) & ": " & Bounded_300.To_String (Swap_String));
      end loop;
   end Client_Task;

   ------------------------------------------
   -- Swap Variable for creating new tasks --
   ------------------------------------------
   Client_Task_Swap : Client_Task_p;
   Client_Task_Counter : Natural := 0;

begin
   -- Start the server socket --
   GNAT.Sockets.Initialize;
   GNAT.Sockets.Create_Socket (Server_Socket);
   Server_Address.Addr := GNAT.Sockets.Inet_Addr ("0.0.0.0");
   Server_Address.Port := 6789;
   GNAT.Sockets.Set_Socket_Option (Socket => Server_Socket,
                                   Level  => GNAT.Sockets.Socket_Level,
                                   Option => (GNAT.Sockets.Reuse_Address, True));

   -- Open the Port --
   GNAT.Sockets.Bind_Socket (Socket  => Server_Socket,
                             Address => Server_Address);

   loop
      -- Listen for a client --
      GNAT.Sockets.Listen_Socket (Server_Socket);
      GNAT.Sockets.Accept_Socket (Server  => Server_Socket,
                                  Socket  => Client_Socket,
                                  Address => Client_Address);

      -- Start a new task to cater for this client --
      Client_Task_Swap := new Client_Task;
      Client_Task_Counter := Natural'Succ (Client_Task_Counter);

      -- Give the task the client socket --
      Client_Task_Swap.Enter_Client_Info (Client_Socket_in => Client_Socket,
                                          Client_Number_in => Client_Task_Counter);
   end loop;

--     GNAT.Sockets.Close_Socket (Server_Socket);
end server;
