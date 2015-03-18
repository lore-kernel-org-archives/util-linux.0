Return-Path: mail@bernhard-voelker.de
Message-ID: <55092A36.7060004@bernhard-voelker.de>
Date: Wed, 18 Mar 2015 08:33:10 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
CC: util-linux@vger.kernel.org
Subject: Re: question about findmnt --target
References: <201503171608.58423.sweet_f_a@gmx.de> <20150317163426.GW28925@ws.net.home>
In-Reply-To: <20150317163426.GW28925@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On 03/17/2015 05:34 PM, Karel Zak wrote:
> Maybe we need a new option to disable the evaluation of the target
> path elements. (--strict-target)

Hey, we already have a tool for that: 'mountpoint' ;-)

What's wrong with

  mountpoint "$DIR_B" >/dev/null \
    && findmnt --target "$DIR_B" \
    && ...

?

Have a nice day,
Berny
