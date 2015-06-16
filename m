Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36412 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbFPFhv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Jun 2015 01:37:51 -0400
Received: by qgal13 with SMTP id l13so1881805qga.3
        for <util-linux@vger.kernel.org>; Mon, 15 Jun 2015 22:37:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
	<20150615133154.GV1992@ws.net.home>
	<CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
Date: Tue, 16 Jun 2015 13:37:50 +0800
Message-ID: <CAGnHSE=X2NCbGRbuzCwcNXALa3udJEx9fv8Rx7WuwFY69U2MiA@mail.gmail.com>
Subject: Re: optimal io size / custom alignment
From: Tom Yan <tom.ty89@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I forgot to highlight that it might be a very bad idea to simply "mod
check" the physical sector size and the optimal i/o size. For one
physical sector size doesn't reflect anything of SSDs. Also as you can
see in my last mail, the optimal i/o size could be huge. (And since
the numbers seem to be "SCSI standards", I'll say it reflects that
they simply means nothing for partition alignment.)

IMHO we should find out in what case (if any) optimal i/o size REALLY
matters for partition alignment, and only use it to derive alignment
for those cases (only if they can be rationally differentiated).

On 16 June 2015 at 13:20, Tom Yan <tom.ty89@gmail.com> wrote:
> http://www.spinics.net/lists/linux-usb/msg125988.html
>
> This optimal i/o size is derived from a "Optimal transfer length"
> provided by the hardware through "VPD". The issue might not have
> seemed common because not all drive provide VPDs and not all driver
> reads them.
>
> From the adapter/drive I have, it is the same as the "Maximum transfer
> length" and they seem to be simply limits of SCSI "WRITE SAME (10/16)"
> command:
>
> [tom@localhost ~]$ sudo sg_inq -p 0xb0 /dev/sdb
> VPD INQUIRY: Block limits page (SBC)
>   Maximum compare and write length: 0 blocks
>   Optimal transfer length granularity: 1 blocks
>   Maximum transfer length: 65535 blocks
>   Optimal transfer length: 65535 blocks
>   Maximum prefetch, xdread, xdwrite transfer length: 65535 blocks
>   Maximum unmap LBA count: 0
>   Maximum unmap block descriptor count: 0
>   Optimal unmap granularity: 0
>   Unmap granularity alignment valid: 0
>   Unmap granularity alignment: 0
>   Maximum write same length: 0x0 blocks
>   Maximum atomic transfer length: 0
>   Atomic alignment: 0
>   Atomic transfer length granularity: 0
>
> [tom@localhost ~]$ sudo sg_inq -p 0xb0 /dev/sdc
> VPD INQUIRY: Block limits page (SBC)
>   Maximum compare and write length: 0 blocks
>   Optimal transfer length granularity: 0 blocks
>   Maximum transfer length: 8388607 blocks
>   Optimal transfer length: 8388607 blocks
>   Maximum prefetch, xdread, xdwrite transfer length: 0 blocks
>
> The thing is, why any io/transfer size/length should be considered
> when it comes to partition alignment? From what I understand,
> partition alignment is only to make sure partition starts at physical
> boundaries of the disk because of the mismatch between logicial sector
> (512 bytes) and physical sectors (4096 bytes) or pages/erase blocks of
> SSDs.
>
> On 15 June 2015 at 21:31, Karel Zak <kzak@redhat.com> wrote:
>> On Sat, Jun 13, 2015 at 10:52:04PM +0800, Tom Yan wrote:
>>> As I have mentioned in previous mails, I have an sata/usb3 adapter
>>> which could work in uas mode, and when it does, it has a weird optimal
>>> i/o size:
>>>
>>> Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
>>> Units: sectors of 1 * 512 = 512 bytes
>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>> I/O size (minimum/optimal): 512 bytes / 33553920 bytes
>>
>> This is no problem (33553920 % 512 = 0) with the current kernel and
>> the current util-linux git tree where we support non power of 2
>> alignment.
>>
>>> http://www.linuxquestions.org/questions/linux-newbie-8/how-to-foramt-2tb-external-hard-drive-4175529792/
>>>
>>> In the above link, there shows another similar case of an external
>>> drive with 4k physical sector.
>>
>> from the link:
>>
>>     Sector size (logical/physical): 512 bytes / 4096 bytes
>>     I/O size (minimum/optimal): 4096 bytes / 33553920 bytes
>>
>> this is problem (33553920 % 4096 != 0) and frankly it seems like
>> pretty strange thing, maybe kernel guys can comment it (CC: to
>> Martin).
>>
>>> I am not sure if there's anything wrong with the device(s) or the
>>> kernel, but anyway I doubt if fdisk should determine alignment with
>>> this size. As you can calculate, it may not necessarily be a multiple
>>> of the size of physical sectors, or that of common erase block of SSDs
>>> (which is not reported anywhere AFAIK).
>>>
>>> Perhaps this I/O size does matter on alignment for certain cases, but
>>> shouldn't physical sector or erase block be at least of higher
>>> priority when it comes to alignment?
>>
>> I think we can test "optimal_io_size % physical_sector_size" and use physical
>> sector size as the granularity if the optimal_io_size is a strange number.
>>
>>> In any case, it would be nice if fdisk can allow customize alignment
>>> (like gdisk does), so that users can at least decide how partitions
>>> should be aligned in weird cases like this. With that, the long-time
>>> deprecated "dos compatibility" might be able to go as well.
>>
>> I'll think about it...
>>
>>     Karel
>>
>>
>> --
>>  Karel Zak  <kzak@redhat.com>
>>  http://karelzak.blogspot.com
