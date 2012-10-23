Return-Path: venkat@linaro.org
MIME-Version: 1.0
In-Reply-To: <20121023121610.GI21724@x2.net.home>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
	<20121023121610.GI21724@x2.net.home>
Date: Tue, 23 Oct 2012 19:07:42 +0530
Message-ID: <CAFSEfh0A6JoKdhDyawc1=imRDZT7YFTUyDrVPaK-02CW1pGcRA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Adding useful information into swap partition header
From: Venkatraman S <venkat@linaro.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, arnd.bergmann@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 23 October 2012 17:46, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Oct 22, 2012 at 10:27:23PM +0530, Venkatraman S wrote:
>> Venkatraman S (4):
>>   libblkid/topology: add preferred_erase_size to topology probe
>>   mkswap: refactor header preparation
>>   mkswap: Add additional fields in swapheader
>>   mkswap: Probe and embed useful block device info into swapheader
>
>  I don't see a problem to support additional information in the swap
>  header, but our rule is pretty simple: first in Linus' tree, after
>  that in userspace.
>

Thanks Karl - that's understood. I posted the patches to better explain the
issue I faced - this new parameter I introduced in topology.c is accessible
only when I pass the root disk dev node to mkswap (as /dev/mmcblkX)
and not when invoked with /dev/mmcblkXpY) (i.e a partition with the device).

So how should the topology probe be invoked in this case ?
Thanks,
Venkat.
