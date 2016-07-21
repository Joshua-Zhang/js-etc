open Async.Std;;

let () =
    let command = Command.async
        ~summary: "etc trading program"
        Command.Spec.(
            empty
            +> flag "-host" (optional_with_default "localhost" string)
                ~doc:"Hostname"
            +> flag "-port" (optional_with_default 25000 int)
                ~doc:"Port"
            +> flag "-name" (optional_with_default "COULOMB" string)
                ~doc:"Team name"
        )
        (fun host port team_name () ->
           printf "Hello from %s at %s:%d\n" team_name host port;
           Network.loop ~host ~port
               ~f:(fun ~line ~write -> print_endline line |> return)
               ~on_connect:(fun write -> write "HELLO COULOMB")
        )
    in
    Command.run command;;
