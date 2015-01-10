Return-Path: bensberg@justemail.net
Message-Id: <1420897225.3552783.212170605.63B41B62@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: setarch cannot set all listed architectures
Date: Sat, 10 Jan 2015 14:40:25 +0100
In-Reply-To: <20150106103514.GC18528@x2.net.home>
References: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
 <20141231083046.GF3906@vapier.wh0rd.info>
 <1420017348.3190622.208236865.6FAABC76@webmail.messagingengine.com>
 <20141231092354.GG3906@vapier.wh0rd.info>
 <20150106103514.GC18528@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


On Tue, Jan 6, 2015, at 11:35, Karel Zak wrote:
>  I think it would be enough to add a note into man page that 
>  things are not perfect and supported features depends on kernel.

Okay.  Patch coming up.


I think it would also be nice if setarch differentiated between not
recognizing any architecture in the provided string and not being
able to set the architecture to the recognized one.  On my machine:

$ ./setarch sometypo uname -m
setarch: sometypo: Unrecognized architecture

$ ./setarch ia64 uname -m
setarch: Kernel cannot set architecture to ia64

This change is included in the upcoming patches, but I have no
idea whether this is correct.


Another thing:

$ ./setarch -BRF --help | tail -1
For more details see setarch(8).

$ ./setarch -BRF --version
setarch from util-linux 2.25.634-8501-dirty

$ ./setarch -BRF --list
./setarch: unrecognized option '--list'
setarch: Try `setarch --help' for more information.

Nowhere does it say that --list cannot be combined with other
options. Instead of adding such a remark, upcoming patch makes
it be accepted in combinations, just like --help and --version.


By the way, in setarch.c there are two occurrences of:
    if (argc < 1)
        show_usage(_("Not enough arguments"));
Isn't the first one superfluous?  I cannot trigger it.


Benno

-- 
http://www.fastmail.com - mmm... Fastmail...
