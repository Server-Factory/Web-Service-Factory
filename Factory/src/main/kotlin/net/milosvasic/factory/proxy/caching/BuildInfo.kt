package net.milosvasic.factory.proxy.caching

import net.milosvasic.factory.application.BuildInformation

object BuildInfo : BuildInformation {

    override val version = "1.0.0 Alpha 1"
    override val versionCode = (100 * 1000) + 0
    override val versionName = "Web Service Factory"

    override fun printName() = "$versionName $version"
}