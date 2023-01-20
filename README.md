# README

- En un principio iba a realizar la App con el flag de --minimal para obtener un codigo mas limpio ya que creo que no era
necesario tener muchos recursos o gemas extras. Pero no se que ocurría que al momento de crear las vistas y modificarlas,
me tiraba error en el "Application HTML" y es por eso que decidí crear el proyecto sin dicho flag. Aun así skipee active-storage
y action-mailbox ya que no iba a utilizarlos.

- Para consumir la API, al comienzo utilicé la gema "HTTParty" pero al poco tiempo noté que la gema "HTTP" contiene más actualizaciones y supuse que eso me daría menos problemas.

- Luego comencé a realizar las acciones Index - Show del controlador y debido a que la información se encuentra en diferentes links de la API me vi obligado a realizar mas de 1 fetch y además, como la información estaba en un Hash dentro de un Array, tuve que hacer un Hash nuevo para tomar los simbols y pushearlos dentro de un array vacío para poder utilizar esa variable de instancia.

- Una vez que ya tenía los datos de la API, empecé a desarrollar sus vistas correspondientes con la utilizacion de Boostrap para darles estilo. Después implementé la gem Kaminari para realizar la paginación del Index.

- Desde un principio solo realizaba el fetch de los pokemones con una cantidad muy reducida y por eso la App mantenía una velocidad normal. Pero luego al probarla con los 1279 pokemones de la API, la App tardaba mucho en cargar. Esto me llevó a reformular la aplicación de la gema Kaminari para que solamente me traiga 9 pokemones cada vez que pasamos de página.

- Después, cuando ya tenía las paginaciones solucionadas, probando y testeando la App noté que ciertos pokemones tenian incovenientes. Algunos no tenian descripcion, fotos, evoluciones e incluso a veces traía la descripcion en otros idiomas asi que a base de condicionales, tuve que solucionarlo.

- Por último, corrí algunos tests en el archivo "test_helper.rb" para chequear ciertas funcionalidades.
