Return-Path: bensberg@justemail.net
Message-Id: <1426434716.3230057.240616189.3072926F@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <550339DA.1060408@gmx.com>
References: <5503364E.6010302@gmx.com> <550339DA.1060408@gmx.com>
Subject: Re: [PATCH 5/5] hwclock: man-page errata
Date: Sun, 15 Mar 2015 16:51:56 +0100
List-ID: <util-linux.vger.kernel.org>


On Fri, Mar 13, 2015, at 20:26, J William Piggott wrote:
> The information I wrote regarding clock crystals was not
> only incomplete, it was wrong. The characteristics of
> quartz crystals is beyond the scope of this man-page. It
> was misguided to attempt to include it. This commit
> removes said information.

Hmm... "man-page errata" is a really vague description of
this patch.  Better: "docs: snip section about crystals from
man page of hwclock".  When so, the above two last sentences
become superfluous.  Oh, and s/is beyond/are beyond/.

Benno

-- 
http://www.fastmail.com - mmm... Fastmail...
