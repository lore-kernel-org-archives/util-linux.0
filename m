Return-Path: bensberg@justemail.net
Message-Id: <1491901946.2458529.941015648.24AD2E35@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Tue, 11 Apr 2017 11:12:26 +0200
In-Reply-To: <0e533bfa-d763-a033-a7dc-dc65bd8ff1ff@gmx.com>
Subject: Re: [PATCH 1/5] hwclock: use errtryhelp()
References: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
 <0e533bfa-d763-a033-a7dc-dc65bd8ff1ff@gmx.com>
List-ID: <util-linux.vger.kernel.org>


On Tue, Apr 11, 2017, at 00:50, J William Piggott wrote:
> 
> * sys-utils/hwclock.c: use errtryhelp() instead of usage().

The commit message (subject line) could be more informative, say:

hwclock: suggest to try --help when an unknown option is given

Benno

-- 
http://www.fastmail.com - Send your email first class
