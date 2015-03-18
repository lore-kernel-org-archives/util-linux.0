Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: question about findmnt --target
Date: Wed, 18 Mar 2015 11:39:45 +0100
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <201503171608.58423.sweet_f_a@gmx.de> <20150317163426.GW28925@ws.net.home> <55092A36.7060004@bernhard-voelker.de>
In-Reply-To: <55092A36.7060004@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201503181139.46639.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 18 March 2015, Bernhard Voelker wrote:
> On 03/17/2015 05:34 PM, Karel Zak wrote:
> > Maybe we need a new option to disable the evaluation of the target
> > path elements. (--strict-target)
>
> Hey, we already have a tool for that: 'mountpoint' ;-)
>
> What's wrong with
>
>   mountpoint "$DIR_B" >/dev/null \
>     && findmnt --target "$DIR_B" \
>     && ...

Yeah! In context of that tests/ts/mount/move snippet this should be 
enough:

[...]
# move
$TS_CMD_MOUNT --move $DIR_A $DIR_B

# check the move
$TS_CMD_MOUNTPOINT -q $DIR_B || ts_failed "Cannot find binded $DIR_B"
[...]

I still wonder why we don't check mount's return value too. Here it 
should always return 0, right?

cu,
Rudi
