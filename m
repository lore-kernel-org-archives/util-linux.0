Return-Path: mail@bernhard-voelker.de
Message-ID: <50D79EBD.2070705@bernhard-voelker.de>
Date: Mon, 24 Dec 2012 01:15:57 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Dave Reisner <dreisner@archlinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Require explicit call to emergency_do_mounts
References: <1356277410-29666-1-git-send-email-dreisner@archlinux.org> <20121223220335.GC25576@x2.redhat.com>
In-Reply-To: <20121223220335.GC25576@x2.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 12/23/2012 11:03 PM, Karel Zak wrote:
>  Ah, I've been faster then my fetchmail -- so I have pushed a
>  little different patch.

Hi Karel,

I got a build error, because there's no make rule for
include/consoles.h. I didn't check if this is the correct
fix, but the following "just worked". ;-)


diff --git a/include/Makemodule.am b/include/Makemodule.am
index 4091896..bef118f 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -8,7 +8,6 @@ dist_noinst_HEADERS += \
        include/canonicalize.h \
        include/carefulputc.h \
        include/closestream.h \
-       include/consoles.h \
        include/cpuset.h \
        include/crc32.h \
        include/env.h \

Have a nice day,
Berny
