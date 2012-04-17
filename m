Return-Path: P@draigBrady.com
Message-ID: <4F8D76AB.2090806@draigBrady.com>
Date: Tue, 17 Apr 2012 14:56:59 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/8] sfdisk: fix silly mbyte typo
References: <4F8D2D12.8070206@bernhard-voelker.de>
In-Reply-To: <4F8D2D12.8070206@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 04/17/2012 09:42 AM, Bernhard Voelker wrote:
> Karel Zak wrote:
> 
>> On Mon, Apr 16, 2012 at 12:22:12PM +0200, Voelker, Bernhard wrote:
>>> Maybe this is better?
>>>
>>> -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
>>> +	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"

Blocks are 1024 bytes in this mode, as confirmed with:
sfdisk -uM -l /dev/sda

cheers,
Pádraig.
