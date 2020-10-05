Return-Path: <SRS0=EFzK=DM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44360C4363D
	for <util-linux@archiver.kernel.org>; Mon,  5 Oct 2020 13:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F237220756
	for <util-linux@archiver.kernel.org>; Mon,  5 Oct 2020 13:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4h7QvJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgJENgA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgJENgA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 5 Oct 2020 09:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601904957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wztTLqDBFjKA9yYy4HdJqYteRR9xspbop6rGdVR1hPc=;
        b=J4h7QvJaBJJNY7ogeWQMHEh0OkHvHsqzoHfuKlg1XNGZkevo6UMp5m7+yLSodewkyI8qFt
        42SlSO36D+64zSX/bjxcngHYaRljF8O/H2d+KLymRmScsevE/wuz3+jml6WvHTom3rU7FI
        +XEvCyLQ0/nbNKfUbF5n1xSFNb1Y0l0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-5EWACZV0OPGUN32webQTsg-1; Mon, 05 Oct 2020 09:35:56 -0400
X-MC-Unique: 5EWACZV0OPGUN32webQTsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7CD418CB726;
        Mon,  5 Oct 2020 13:35:54 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (unknown [10.10.115.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D485C282CA;
        Mon,  5 Oct 2020 13:35:53 +0000 (UTC)
Date:   Mon, 5 Oct 2020 08:35:50 -0500
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Karel Zak <kzak@redhat.com>,
        'Masayoshi Mizuma' <msys.mizuma@gmail.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20201005133550.e5zvvtdfv44r64o2@tarantula.users.ipa.redhat.com>
Mail-Followup-To: "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>,
        Karel Zak <kzak@redhat.com>,
        'Masayoshi Mizuma' <msys.mizuma@gmail.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
 <20200930184917.z7sx7xxazhdkumvy@gabell>
 <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
 <20201001030519.6d65sqhd54oxmlic@gabell>
 <OSBPR01MB460011A4773B0250C55ED8E7F7310@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <OSBPR01MB460011A4773B0250C55ED8E7F7310@OSBPR01MB4600.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Oct 02, 2020 at 12:15:39PM +0000, nakamura.shun@fujitsu.com wrote:
>Hi Karel, Jeffrey, Mizuma-san
>
>Sorry for the late reply.
>
>> From: Masayoshi Mizuma <msys.mizuma@gmail.com>
>> Sent: Thursday, October 1, 2020 12:05 PM
>> To: Jeffrey Bastian <jbastian@redhat.com>
>> Cc: Karel Zak <kzak@redhat.com>; Nakamura, Shunsuke
>> <nakamura.shun@fujitsu.com>; util-linux@vger.kernel.org; Nakamura,
>> Shunsuke <nakamura.shun@fujitsu.com>
>> Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
>>
>> On Wed, Sep 30, 2020 at 04:53:34PM -0500, Jeffrey Bastian wrote:
>> > On Wed, Sep 30, 2020 at 02:49:17PM -0400, Masayoshi Mizuma wrote:
>> > > Hi Jeffrey and Karel,
>> > >
>> > > On Wed, Sep 30, 2020 at 07:40:27PM +0200, Karel Zak wrote:
>> > > > On Wed, Sep 30, 2020 at 09:44:09AM -0500, Jeffrey Bastian wrote:
>> > > > > On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
>> > > > > > On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura
>> wrote:
>> > > > > > >  sys-utils/lscpu-arm.c | 6 ++++++
>> > > > > > >  1 file changed, 6 insertions(+)
>> > > > > >
>> > > > > > Applied, thanks.
>> > > > >
>> > > > >
>> > > > > With the other ARM patch applied ("use SMBIOS tables on ARM for
>> > > > > lscpu"), the output changes on an FX700 system:
>> > > > >
>> > > > > [root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
>> > > > > Vendor ID:                       FUJITSU
>> > > > > Model:                           0
>> > > > > Model name:                      461F0010
>> > > > > Stepping:                        0x1
>> > > > >
>> > > > >
>> > > > > The values here come from the SMBIOS Type 4 record:
>> > > > >
>> > > > > [root@fujitsu-fx700 ~]# strings
>> > > > > /sys/firmware/dmi/entries/4-0/raw
>> > > > > CPU1
>> > > > > FUJITSU
>> > > > > 461F0010
>> > > > > 8K083MH14
>> > > > >
>> > > > >
>> > > > > This FX700 system has firmware revision 1.4.0 (Jun 17 2020).
>> > > >
>> > > > hmm... 461F0010 does not seem user-friendly, "A64FX" seems better.
>> > > >
>> > > > Shunsuke, what about to update the firmware strings? ;-) (as
>> > > > Jeffrey suggested in RH bugzilla)
>> > > >
>> > > > The another possibility is to exclude some vendors and do not use
>> > > > SMBIOS for them (e.g. 0x46 for Fujitsu), but from my point of view
>> > > > SMBIOS based solution is more elegant and ready for new CPU types
>> > > > than in-lscpu hard coded tables.
>> > >
>> > > According to SMBIOS specification, the description of Processor
>> > > Version (Type4) is "String number describing the Processor". It
>> > > shows the version number of the processor, not a model, like as A64FX and
>> Cortex-A72 and so on.
>> > > So I think we should not use the Processor Version as the modelname...
>> >
>> > Hello Masa,
>> >
>> > I think I see your confusion because I was also confused by the
>> > wording of the SMBIOS spec.  In this case, "String number" means the
>> > number of the string appended to the Type 4 record, not a version
>> > number of the processor.
>> >
>> > See section 6.1.3, "Text strings", of the SMBIOS spec (version 3.4.0).
>> >
>> > For Type 4, there can be up to 6 strings appended to the table:
>> >   Offset 0x04: Socket Designation
>> >   Offset 0x07: Processor Manufacturer
>> >   Offset 0x10: Processor Version
>> >   Offset 0x20: Serial Number
>> >   Offset 0x21: Asset Tag
>> >   Offset 0x22: Part Number
>> >
>> > Each string is optional.  If the byte at one of the above offsets is
>> > 0, that means the string is not included.  If the byte is non-0, it
>> > means refer to the first or second or third (or so on) string appended
>> > to the table.  It's this non-0 number that the spec calls "String number".
>>
>> Ohh... thank you for pointing it out! I misunderstood about "String number".
>>
>> >
>> > Example:
>> >
>> > A Type 4 record that only defined Processor Manufacturer and Processor
>> > Version would therefore look like:
>> >   Offset 0x04: 0x00
>> >   Offset 0x07: 0x01
>> >   Offset 0x10: 0x02
>> >   Offset 0x20: 0x00
>> >   Offset 0x21: 0x00
>> >   Offset 0x22: 0x00
>> >
>> > The text of each string is free form.  Most vendors have chosen to use
>> > Processor Manufacturer as the CPU vendor, and Processor Version as a
>> > text description of the CPU.
>> >
>> > Some examples from existing servers (copy/paste from the other thread):
>> >
>> > [root@hp-m400 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
>> > Vendor ID:                       AppliedMicro
>> > Model:                           1
>> > Model name:                      X-Gene
>> > Stepping:                        0x0
>> >
>> > [root@lenovo-hr330a ~]# ./lscpu | grep -i -e vendor -e model -e stepping
>> > Vendor ID:                       Ampere(TM)
>> > Model:                           2
>> > Model name:                      eMAG
>> > Stepping:                        0x3
>> >
>> > [root@hpe-apollo-70 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
>> > Vendor ID:                       Cavium Inc.
>> > Model:                           1
>> > Model name:                      Cavium ThunderX2(R) CPU CN9980 v2.1
>> @ 2.20GHz
>> > Stepping:                        0x1
>> >
>> >
>> > Therefore, I believe you are free to change the string "461F0010" to
>> > "A64FX" in the SMBIOS Type 4 record of the FX700 and FX1000 servers'
>> > firmware.
>>
>> Thanks, I got the most vendors put their CPU model name to Processor Version,
>> however it depends on the vendor, right..? That's because the SMBIOS
>> specification says just "String number describing the Processor", so vendors can
>> put any strings to describe the own processor, like "461F0010"...
>>
>> But I don't have strong opinion about the Processor Version of A64FX, let's wait
>> for Shunsuke's comment.
>
>I checked with the person in charge.
>
>When the A64FX was designed, there was ambiguity in the Processer Version specification.
>Therefore we defined it as "461F0010".
>Considering the maintenance cost to keep up with the latest CPU, I agree to get information
>from the SMBIOS table rather than the hard code.
>However, as Mizuma-san said, since "Processer Version" specs depends on the interpretation
>of the vendor, the expected value is not output in the processor group existing in the current table
>as in the case of the A64FX.
>
>Given these, I propose referring to the SMBIOS table if the processor version does not exist in
>the current table. Can you give me your opinion?


My motivation for writing the SMBIOS patch was the exact opposite
problem: the original AppliedMicro X-Gene and newer Ampere eMAG are both
identified as X-Gene by lscpu when using the hard-coded tables.
(AppliedMicro was acquired by Macom, then the server CPU team split out
into a new company named Ampere and the X-Gene 3 was rebranded as eMAG.)
The X-Gene output on an eMAG system is often confusing to people
(including myself).

The "CPU implementer" and "CPU part" values are the same for X-Gene and
eMAG.  The difference is in the "CPU variant" field, but lscpu does not
use the variant number in its tables.

## X-Gene
~]# grep -m5 CPU /proc/cpuinfo
CPU implementer : 0x50
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x000
CPU revision    : 1

## eMAG
~]# grep -m5 CPU /proc/cpuinfo
CPU implementer : 0x50
CPU architecture: 8
CPU variant     : 0x3
CPU part        : 0x000
CPU revision    : 2


I thought about trying to extend lscpu to add the variant value to the
tables, but then I realized the strings already exist in SMBIOS Type 4.
Furthermore, using SMBIOS Type 4 reduces the maintenance costs for lscpu
since it no longer needs the hard-coded tables (at least for servers).


-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat

