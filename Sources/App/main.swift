import Vapor
import Foundation

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }

// Configuração da porta e host
app.http.server.configuration.hostname = "0.0.0.0"
app.http.server.configuration.port = 8080

struct CalcReq: Content {
    let operador: String
    let op1: Double
    let op2: Double
}

struct CalcRes: Content {
    let container_host: String
    let resultado: Double
}

app.post("calcular") { req -> CalcRes in
    let calcReq = try req.content.decode(CalcReq.self)
    let res: Double
    
    switch calcReq.operador {
    case "soma":
        res = calcReq.op1 + calcReq.op2
    case "subtracao":
        res = calcReq.op1 - calcReq.op2
    case "multiplicacao":
        res = calcReq.op1 * calcReq.op2
    case "divisao":
        res = calcReq.op2 != 0 ? calcReq.op1 / calcReq.op2 : 0
    default:
        res = 0
    }
    
    let host = ProcessInfo.processInfo.hostName
    return CalcRes(container_host: host, resultado: res)
}

try app.run()
