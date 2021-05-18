package net.milosvasic.factory.mail.application

import com.apple.eawt.Application
import net.milosvasic.factory.log
import net.milosvasic.factory.platform.OperatingSystem
import net.milosvasic.factory.platform.Platform
import net.milosvasic.factory.web_service.application.BuildInfo
import java.io.IOException
import javax.imageio.ImageIO

object OSInit : Runnable {

    @Throws(
            IllegalArgumentException::class,
            NullPointerException::class,
            SecurityException::class,
            IOException::class
    )
    override fun run() {

        log.v("Starting: ${BuildInfo.versionName}, ${BuildInfo.version}")
        val hostOS = OperatingSystem.getHostOperatingSystem()
        val iconResourceName = "assets/Logo.png"
        val iconResource = hostOS::class.java.classLoader.getResourceAsStream(iconResourceName)
        val icon = ImageIO.read(iconResource)
        if (hostOS.getPlatform() == Platform.MAC_OS) {

            System.setProperty("apple.awt.application.name", BuildInfo.printName())
            val app = Application.getApplication()
            app.dockIconImage = icon
        }
    }
}