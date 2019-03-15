Return-Path: <SRS0=KEke=RS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80CAC43381
	for <util-linux@archiver.kernel.org>; Fri, 15 Mar 2019 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0157217F5
	for <util-linux@archiver.kernel.org>; Fri, 15 Mar 2019 14:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfCOOGF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:06:05 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:54210 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfCOOGF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Mar 2019 10:06:05 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id x2FE5teO036931;
        Fri, 15 Mar 2019 07:05:58 -0700
Message-ID: <5C8BB144.1060305@tlinx.org>
Date:   Fri, 15 Mar 2019 07:05:56 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
CC:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re:why would 4k size for phys sector size read in kernel, go away?
References: <5C86CBA1.40802@tlinx.org> <20190311212104.edekhgctqto37tn7@gallifrey> <5C86D476.6060807@tlinx.org> <20190312082159.jojrjq7ox3d457ke@ws.net.home> <5C87CA04.1010308@tlinx.org> <20190312181141.l3hj2gf5l4dxiniy@gallifrey>
In-Reply-To: <20190312181141.l3hj2gf5l4dxiniy@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 3/12/2019 11:11 AM, Dr. David Alan Gilbert wrote:
>
>
> megacli is a special for LSI RAID controllers isn't it?
> If so, then perhaps the RAID controller is hiding some info depending
> on how it's configured and using a special to get the info from the controller.
>
> How about trying one of the SCSI utils, like sginfo -a ?
>   
It didn't show anything about blocksize logical or physical.

The only thing I see Megacli doing s searching through
/sys/, it seems to find the name of the controller,

then opening (FD3)
"/dev/megaraid_sas_ioctl_node

then issuing a bunch of

ioctl(3, MCE_GET_RECORD_LEN or MEMGETINFO or MTRRIOC_SET_ENTRY, 0x7cb9e0)

calls after which it dumps all the info about the disks in the RAIDS.
Of note.. these are disks in external enclosures that are
connected via the LSI controller.

Also of note, I am certain that the physical size of the blocks
for the 4K blocks used to show 4096 bytes as I had written
scripts to pull this information.

I also am fairly sure I remember seeing the temperatures listed
somewhere, but I didn't write a supporting script to display
that info.

While megacli does seem to use an ioctl of the device,
(haven't looked at source of driver yet) that doesn't negate that
sysfs USED to display the correct blocksize.  My minor concern is that
if the kernel doesn't know the real size of the blocks, no way
disk utils will know and have concerns about something eventually
getting it off by 1 or such.  Depending on what disk it is, I might
not notice it until it was a large pain to reformat it correctly.

FWIW, I've been unable to find a source for megacli...





