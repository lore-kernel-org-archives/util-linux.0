Return-Path: rolf@rolffokkens.nl
Date: Wed, 11 Sep 2013 13:59:10 +0200
Subject: Re: bcache-tools package for Fedora / status probe-bcache
From: Rolf Fokkens <rolf@rolffokkens.nl>
To: Gabriel de Perthuis <g2p.code@gmail.com>, Karel Zak <kzak@redhat.com>
CC: "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        util-linux <util-linux@vger.kernel.org>
Message-ID: <CE5623FD.1AC8F%rolf@rolffokkens.nl>
In-Reply-To: <522DE939.5090009@gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
List-ID: <util-linux.vger.kernel.org>

Op 09-09-13 17:28 schreef Gabriel de Perthuis <g2p.code@gmail.com>:

>> Maybe we can backport the patch to F20 if you need it -- it's not too
>>  invasive change.
>
>(Letting Rolf field this one)

Most important for me is to have bcache identification by blkid in before
F20, so the udev rules file doesn't have to call bcache-probe. Whether or
not it uses checksums is not the most important thing, and that aspect
might even change later.
