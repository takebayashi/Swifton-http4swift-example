import Nest
import Swifton
import http4swift

class MainController: Controller {
  override init() {
    super.init()
    action("index") { request in
      self.renderJSON(["message": "hello, world!"])
    }
  }
}

let router = Router()
router.resources("greetings", MainController())

let port = UInt16(Process.arguments[1])!
let addr = SocketAddress(port: port)
let sock = Socket()!
let server = HTTPServer(socket: sock, addr: addr)!
server.serve { req in
  router.respond(req)
}
