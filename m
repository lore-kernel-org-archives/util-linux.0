Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:34555 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2IOG3x (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 15 Sep 2012 02:29:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id A393719B819
	for <util-linux@vger.kernel.org>; Sat, 15 Sep 2012 09:29:51 +0300 (EEST)
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id lPQ5T3zLvkw4 for <util-linux@vger.kernel.org>;
	Sat, 15 Sep 2012 09:29:51 +0300 (EEST)
Received: from michael.steam.fi.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp5.welho.com (Postfix) with ESMTPS id 5B24A5BC003
	for <util-linux@vger.kernel.org>; Sat, 15 Sep 2012 09:29:51 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] AUTHORS, NEWS: UTF-8 fixes.
Date: Sat, 15 Sep 2012 09:29:50 +0300
Message-Id: <1347690590-29482-2-git-send-email-ville.skytta@iki.fi>
In-Reply-To: <1347690590-29482-1-git-send-email-ville.skytta@iki.fi>
References: <1347690590-29482-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville SkyttÃ¤ <ville.skytta@iki.fi>
---
 AUTHORS |  5 ++---
 NEWS    | 34 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index 774fb50..47334f9 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -120,7 +120,6 @@ CONTRIBUTORS:
       Davidlohr Bueso <dave@gnu.org>
       David Miller <davem@davemloft.net>
       David PrÃ©vot <david@tilapin.org>
-      David Prévot <david@tilapin.org>
       David Woodhouse <dwmw2@infradead.org>
       Denis ChengRq <crquan@gmail.com>
       Dennis Gilmore <dennis@ausil.us>
@@ -172,7 +171,7 @@ CONTRIBUTORS:
       Igor Bazhitov <igor.bazhitov@gmail.com>
       Ilias Mamedov <arknir@yandex.ru>
       Imre Kaloz <kaloz@openwrt.org>
-      Jaakko Hyvätti <HYVATTI@cc.helsinki.fi>
+      Jaakko HyvÃ¤tti <HYVATTI@cc.helsinki.fi>
       Jakob Unterwurzacher <jakobunt@gmail.com>
       Jakub Bogusz <qboosh@pld-linux.org>
       James Le Cuirot <chewi@aura-online.co.uk>
@@ -241,7 +240,7 @@ CONTRIBUTORS:
       Martin Steigerwald <ms@teamix.de>
       Masatake YAMATO <yamato@redhat.com>
       Matthew Garrett <mjg59@srcf.ucam.org>
-      Matthias König <mk@phasorlab.de>
+      Matthias KÃ¶nig <mk@phasorlab.de>
       Matthias Koenig <mkoenig@suse.de>
       Maurizio Lombardi <m.lombardi85@gmail.com>
       maximilian attems <max@stro.at>
diff --git a/NEWS b/NEWS
index 6c292a5..1c84a88 100644
--- a/NEWS
+++ b/NEWS
@@ -323,7 +323,7 @@ util-linux 2.12a
 * chfn, chsh, login, vipw: SElinux support
 * fdisk: fix for kernels 2.4.15-2.4.17
 * fdisk: fix when all partitions are in use
-* hwclock: add a timeout when waiting for a clock update (Göran Weinholt)
+* hwclock: add a timeout when waiting for a clock update (GÃ¶ran Weinholt)
 * ipcs: compilation fix
 * ipcs: shminfo.shmall gives pages
 * login: use getutline() instead of getutid()
@@ -356,7 +356,7 @@ util-linux 2.12pre
 * Slovenian messages (Primoz Peterlin)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * cfdisk: localize the Y/N answer, improve printing localized messages
 * cfdisk: make various variables long long - some disks are close to 2 TB
 * cfdisk: use BLKGETSIZE64
@@ -392,7 +392,7 @@ util-linux 2.11z
 * Slovenian messages (Primoz Peterlin)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * getopt: replaced getopt-1.1.2 by getopt-1.1.3 (Frodo Looijaard)
 * mkcramfs: change default blocksize for ia64 and alpha
 * more.help: removed (it is built-in now, and translated)
@@ -429,7 +429,7 @@ util-linux 2.11x
 * Finnish messages (Lauri Nurmi)
 * German messages (Michael Piefel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * cfdisk: correct error printout
 * fdisk: allow addition of a new partition when logicals all used
   but primary free
@@ -463,7 +463,7 @@ util-linux 2.11v
 * Slovenian messages (Primoz Peterlin)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * fdisk: add -C, -H, -S command line options
 * fdisk: allow changing type 0
 * mkswap: enable use of > 2GB swapspace
@@ -479,7 +479,7 @@ util-linux 2.11u
 * German messages (Michael Piefel)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * configure: for fsck.cramfs, mkfs.cramfs: add test for libz
 * text-utils/Makefile: pg fix (Toomas Rosin)
 * po/Makefile: typo fix (Silvan Minghetti)
@@ -514,7 +514,7 @@ util-linux 2.11s
 * German messages (Michael Piefel)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * MCONFIG: allow "make DISABLE_NLS=yes <target>" (Peter Breitenlohner)
 * configure: don't run ./conftest - better for cross-compilation (Magnus Damm)
 * fdisk: fixes for disks with OSF/1 label
@@ -540,11 +540,11 @@ util-linux 2.11r
 * German messages (Michael Piefel)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * MCONFIG: move $(CFLAGS) to the end to allow overrides (Kevin P. Fleming)
 * cal: tiny fix (Mitsuru Chinen)
 * fdisk: avoid <linux/hdreg.h>
-* fdisk: x86_64 patch (Mads Martin Jørgensen)
+* fdisk: x86_64 patch (Mads Martin JÃ¸rgensen)
 * hwclock.8: zoneinfo is now in /usr/share
 * mkswap: report in KiB instead of bytes.
 
@@ -562,7 +562,7 @@ util-linux 2.11p
 * German messages (Karl Eichwalder)
 * Spanish messages (Santiago Vila Doncel)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * ipcrm: make POSIX compatible (Andre Corwin Mazzone)
 * ipcrm.8: idem
 * kill: fixed Makefile
@@ -604,7 +604,7 @@ util-linux 2.11n
 * Danish messages (Claus Hindsgaul)
 * German messages (Karl Eichwalder)
 * Swedish messages (Christian Rose)
-* Turkish messages now in UTF-8 (Nilgün Belma Bugüner)
+* Turkish messages now in UTF-8 (NilgÃ¼n Belma BugÃ¼ner)
 * blockdev: add --report option
 * cal: fix for wide multibyte-char (Motonobu Ichimura)
 * cfdisk: recognize ext3 and reiserfs (Flavio Stanchina)
@@ -623,7 +623,7 @@ util-linux 2.11m
 * Danish messages (Claus Hindsgaul)
 * German messages (Karl Eichwalder)
 * Swedish messages (Christian Rose)
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * fdisk: added netbsd type (Steven J. Hill)
 * more: fix for unsigned char (Rusty Russell)
 * mount: added sysv magic (Tim Launchbury)
@@ -686,7 +686,7 @@ util-linux 2.11i
 
 util-linux 2.11h
 
-* Turkish messages (Nilgün Belma Bugüner)
+* Turkish messages (NilgÃ¼n Belma BugÃ¼ner)
 * Danish messages (Claus Hindsgaul)
 * banner: minor fix (awayzzz@digibel.org)
 * mkfs.minix: minix v2 fix
@@ -711,7 +711,7 @@ util-linux 2.11g
 
 util-linux 2.11f
 
-* Czech messages (Jiøí Pavlovský)
+* Czech messages (JiÅ™Ã­ PavlovskÃ½)
 * fdisk: fix for "reorder" expert command
   (use of sfdisk afterwards is still recommended)
 * mount: minor fixes
@@ -748,7 +748,7 @@ util-linux 2.11d
 
 util-linux 2.11c
 
-* Czech messages (Jiøí Pavlovský)
+* Czech messages (JiÅ™Ã­ PavlovskÃ½)
 * German messages (Elrond)
 * Makefile/MCONFIG improvements (Peter Breitenlohner)
 * fdisk: added a few partition types
@@ -1052,7 +1052,7 @@ util-linux 2.9v:
 
 util-linux 2.9u:
 
-* Czech more.help and messages (Jiøí Pavlovský)
+* Czech more.help and messages (JiÅ™Ã­ PavlovskÃ½)
 * Japanese messages (Daisuke Yamashita)
 * fdisk fix (Klaus G. Wagner)
 * mount fix (Hirokazu Takahashi)
@@ -1066,7 +1066,7 @@ util-linux 2.9t:
 * national language support for hwclock
 * Japanese messages (both by Daisuke Yamashita)
 * German messages and some misc i18n fixes (Elrond)
-* Czech messages (Jiøí Pavlovský)
+* Czech messages (JiÅ™Ã­ PavlovskÃ½)
 * wall fixed for /dev/pts/xx ttys
 * make last and wall use getutent() (Sascha Schumann)
   [Maybe this is bad: last reading all of wtmp may be too slow.
-- 
1.7.11.4

