Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84DAC4167B
	for <util-linux@archiver.kernel.org>; Mon, 13 Nov 2023 17:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKMRuK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 Nov 2023 12:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRuK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Nov 2023 12:50:10 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651C1706
        for <util-linux@vger.kernel.org>; Mon, 13 Nov 2023 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699897804; bh=Df3rD0T0lZvHUST8EZbRHxFNSuBgc7RckhNc+9Ex3Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjTNbyeTZ7Uj9Q4lRDwFC7LyM3L7uyWIMXn4Zn9su6dm/DGoZdo9SMp2GB1siB2rM
         I8B8kOU5XAKnS95wnDAy54rm5D3OuV3UPgm73SlQqrc0LAC5WIc5pDgkpbFdS9JONh
         Y3O6IZB6IT/qvZAt0tINWM1uDok066UqdipFyGFI=
Date:   Mon, 13 Nov 2023 18:50:03 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: RFH: fincore/count lsfd/column-xmode failing on sparc64
Message-ID: <d687e9b1-747a-4194-9155-8e919544cfed@t-8ch.de>
References: <2eedea423b789396d263ff4aef05736ea48d4f46.camel@physik.fu-berlin.de>
 <27dc0b31-bfd5-4519-b46e-c0bcafe0702a@t-8ch.de>
 <dfb16443d2e030e2738d83a886572fdddc64f7ba.camel@physik.fu-berlin.de>
 <b5dcde27-d08d-4b2e-80df-1a1edf8e447b@t-8ch.de>
 <19872ac4428190b3825e1f34cddca175aee0e8ae.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19872ac4428190b3825e1f34cddca175aee0e8ae.camel@physik.fu-berlin.de>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-11-12 08:53:28+0100, John Paul Adrian Glaubitz wrote:
> On Sat, 2023-11-11 at 20:10 +0100, Thomas Weißschuh wrote:
> [..]
> > I can also take a look on Monday.
> 
> Great, thank you!

What's your system's page size?

./test_sysinfo


Do you have a VM image available I could use?
I was not able to make the available Debian images work and could not
reproduce the issue on the Ubuntu images.


Thomas
