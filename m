Return-Path: g2p.code@gmail.com
Message-ID: <523487DC.1070704@gmail.com>
Date: Sat, 14 Sep 2013 17:59:24 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: Abort after an incorrect checksum
References: <1378491089-1135-1-git-send-email-g2p.code@gmail.com> <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
In-Reply-To: <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

> Log incorrect checksums and stop the superblock probing loop when
> one is encountered.
> This is to avoid exposing backend devices that are supposed
> to be used through a stacked device (like raid or bcache).

Sorry, but some of the changes you made when applying break the patch.
The intent is to stop the probing loop when a bad container is encountered;
the contents shouldn't be scanned.

That means returning an error from the sb-specific prober doesn't work,
and deferring to superblocks_probe was necessary.  I'll send a followup patch.
