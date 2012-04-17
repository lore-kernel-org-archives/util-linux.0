Return-Path: mail@bernhard-voelker.de
Message-ID: <4F8D8562.2020805@bernhard-voelker.de>
Date: Tue, 17 Apr 2012 16:59:46 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/8] sfdisk: fix silly mbyte typo
References: <4F8D2D12.8070206@bernhard-voelker.de> <4F8D76AB.2090806@draigBrady.com> <4F8D7AB3.1010406@bernhard-voelker.de> <4F8D7EEF.8060601@draigBrady.com> <20120417144801.GA2391@x2.net.home>
In-Reply-To: <20120417144801.GA2391@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>



On 04/17/2012 04:48 PM, Karel Zak wrote:
>  yep, my +1 was about s/mebibytes/MiB/, I have overlooked the
>  1024*1024 math in the patch. Pádraig is right, (s)fdisk uses 1024
>  byte blocks in output 

so KiB would be right?

>  (probably too keep things more confusing ;-)

mission accomplished ...

Bye,
Berny
