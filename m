Return-Path: lkml@tlinx.org
Message-ID: <5936C623.4030205@tlinx.org>
Date: Tue, 06 Jun 2017 08:11:31 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
References: <5935E44B.8000405@tlinx.org> <20170606093607.xrxel4ny4hjoe4iv@ws.net.home> <5936B8E5.8050901@tlinx.org>
In-Reply-To: <5936B8E5.8050901@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

L A Walsh wrote:
>
>    But my EUID isn't 5013 ("LOGINUID" is). That's the complaint/bug.
---
FWIW, I display them in perl, and they also show 0/0:
 sudo bash -c 'perl -e "use P;P \"UID=$<, EUID=$>\""; /bin/mount devpts 
/tmp/mnt -t devpts'   
UID=0, EUID=0
mount: only root can use "--types" option (effective UID is 5013)

I.e. both bash & perl show UID/EUID being 0 before I call mount.
I don't get it.

I looked at mount's src-code, and have no idea why it's not
returning the right value.
