with GNAT.Sockets;
with common_types; use common_types;
with Ada.Text_IO;

procedure client is
   Client_Socket  : GNAT.Sockets.Socket_Type;
   Server_Address : GNAT.Sockets.Sock_Addr_Type;
   Client_Number  : Positive;
   Channel        : GNAT.Sockets.Stream_Access;

   Swap_String : Bounded_300.Bounded_String;
begin
   -- Start a socket
   GNAT.Sockets.Initialize;
   GNAT.Sockets.Create_Socket (Client_Socket);
   Server_Address.Addr := GNAT.Sockets.Inet_Addr ("127.0.0.1");
   Server_Address.Port := 6789;

   -- Connect socket to server
   GNAT.Sockets.Connect_Socket (Client_Socket, Server_Address);
   Channel := GNAT.Sockets.Stream (Client_Socket);

   -- Get Client Number
   Positive'Read (Channel, Client_Number);
   Ada.Text_IO.Put_Line ("I am client" & Positive'Image (Client_Number));

   -- Get text from user and send to server
   loop
      Swap_String := Bounded_300.To_Bounded_String (Ada.Text_IO.Get_Line);
      Bounded_300.Bounded_String'Write (Channel, Swap_String);
      exit when Bounded_300.Length (Swap_String) = 0;
   end loop;

   GNAT.Sockets.Close_Socket (Client_Socket);
end client;
