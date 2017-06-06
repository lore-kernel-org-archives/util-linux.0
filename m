Return-Path: lkml@tlinx.org
Message-ID: <5936D40E.3040000@tlinx.org>
Date: Tue, 06 Jun 2017 09:10:54 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Tilman Schmidt <tilman@imap.cc>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
References: <5935E44B.8000405@tlinx.org> <20170606093607.xrxel4ny4hjoe4iv@ws.net.home> <5936B8E5.8050901@tlinx.org> <5936C623.4030205@tlinx.org> <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com>
In-Reply-To: <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Tilman Schmidt wrote:
> What does "ls -l /bin/mount" say?
> Is its owner the user with UID 5013, by any chance?
>   
Bingo.

Maybe the install should check to see
if it is root before setting a SUID bit on the executable?

Thank & good call!
