Return-Path: bruce.dubbs@gmail.com
Subject: Re: fdisk request for functionality (or info)
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
References: <59D3C162.4050005@gmail.com>
 <20171004082728.if274peupxjljbxd@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <59D4F322.7040805@gmail.com>
Date: Wed, 4 Oct 2017 09:41:38 -0500
MIME-Version: 1.0
In-Reply-To: <20171004082728.if274peupxjljbxd@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Oct 03, 2017 at 11:57:06AM -0500, Bruce Dubbs wrote:
>> I have been having a problem with fdisk on old computers.
>>
>> What I am doing is installing Debian, but dropping to the command line and
>> creating a GPT manually because Debian seems to want to always create a
>> msdos partition table.
>>
>> After creating the GPT and partitioning, the install proceeds normally, but
>> upon reboot the old bios tells me "No bootable disk".
>>
>> I can fix this by going into rescue mode and setting the pmbr_boot flag
>> using parted.
>>
>> My question is whether this can be done in fdisk.  If not, can it be added?
>>
>> I did try going into expert mode and selecting "toggle the legacy BIOS
>> bootable flag", but does not seem to work.  I did not see any change to the
>> boot sector when using 'd: print the raw data of the first sector from the
>> device'.
>
> The tricky thing is that fdisks by default see GPT partition, so you
> have to force the tools to ignore GPT and use PMBR. There is more
> ways:

> 2) start fdisk as usually
>      - go to expert mode ('r')

There is not an 'r' mode, only 'x' when the current table is gpt.

>      - see help ('m')
>      - switch to nested label ('M')
>      - go to main menu ('r')
>      - toggle boot flag ('a')
>      - write ('w')

I wasn't sure if the 'pmbr_boot' flag was just the standard mbr boot flag 
for partition 1 or not.  Would it be reasonable to set that flag by 
default when 'g create a new empty GPT partition table' is selected?

   -- Bruce
