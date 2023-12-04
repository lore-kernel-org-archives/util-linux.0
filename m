X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 13:18:25 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [185.233.100.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832490
	for <util-linux@vger.kernel.org>; Mon,  4 Dec 2023 13:18:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 7FD2BA20;
	Mon,  4 Dec 2023 22:08:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0PBTbssEt-n; Mon,  4 Dec 2023 22:08:45 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:cca:f000:de41:a9ff:fe47:ec49])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 11D071BD;
	Mon,  4 Dec 2023 22:08:45 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@aquilenet.fr>)
	id 1rAGBI-00000003igg-0VLp;
	Mon, 04 Dec 2023 22:08:44 +0100
Date: Mon, 4 Dec 2023 22:08:44 +0100
From: Samuel Thibault <samuel.thibault@aquilenet.fr>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.39.3
Message-ID: <20231204210844.32vk3tr32rwqonar@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
	Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20231204200508.mtdmxgrsvhux7m7s@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="syztp6rvafvjzxsx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204200508.mtdmxgrsvhux7m7s@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)


--syztp6rvafvjzxsx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Karel Zak, le lun. 04 déc. 2023 21:05:08 +0100, a ecrit:
> The util-linux stable release v2.39.3 is available at
>  
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.39/

Here a fix for non-Linux builds.

Samuel

--syztp6rvafvjzxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 19b80ec6e..8b9bbc24d 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -962,6 +962,7 @@ failed:
 
 #endif
 
+#ifdef BLKIOOPT
 static uint64_t blkid_get_io_size(int fd)
 {
 	static const int ioctls[] = { BLKIOOPT, BLKIOMIN, BLKBSZGET };
@@ -977,6 +978,7 @@ static uint64_t blkid_get_io_size(int fd)
 
 	return DEFAULT_SECTOR_SIZE;
 }
+#endif
 
 /**
  * blkid_probe_set_device:
@@ -1185,8 +1187,10 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	}
 # endif
 
+#ifdef BLKIOOPT
 	if (S_ISBLK(sb.st_mode) && !is_floppy && !blkid_probe_is_tiny(pr))
 		pr->io_size = blkid_get_io_size(fd);
+#endif
 
 	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%"PRIu64", size=%"PRIu64", zonesize=%"PRIu64", iosize=%"PRIu64,
 				pr->off, pr->size, pr->zone_size, pr->io_size));

--syztp6rvafvjzxsx--
