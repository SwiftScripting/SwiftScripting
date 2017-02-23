import Commander
import Foundation
import QuickTimePlayer
import ScriptingBridge
import ScriptingSupport

func getVideo() -> QuickTimePlayerDocument? {
    let qt = application(name: "QuickTime Player") as? QuickTimePlayerApplication
    return qt?.documents?().firstObject as? QuickTimePlayerDocument
}

func jumpBy(_ delta: Double) {
    print("Jumping by \(delta) seconds")
    let video = getVideo()
    video?.setCurrentTime?((video?.currentTime ?? 0) + delta)
}

func setRate(_ rate: Double) {
    print("Setting rate to \(rate)x")
    getVideo()?.setRate?(rate)
}

func pause() {
    print("Pausing")
    getVideo()?.pause?()
}

func play() {
    print("Playing")
    getVideo()?.play?()
}

let main = Group {
    $0.command("ff") { (delta: Double) in
        jumpBy(delta)
    }

    $0.command("rew") { (delta: Double) in
        jumpBy(-delta)
    }

    $0.command("rate") { (rate: Double) in
        setRate(rate)
    }

    $0.command("pause") {
        pause()
    }

    $0.command("play") {
        play()
    }
}

main.run()
