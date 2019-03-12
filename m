Return-Path: <SRS0=rvHk=RP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01587C43381
	for <util-linux@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE8213A2
	for <util-linux@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="edqItxPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCLSLu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:11:50 -0400
Received: from mx.treblig.org ([46.43.15.161]:60984 "EHLO mx.treblig.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfCLSLq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Mar 2019 14:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=dN52BX2Tp87gvxCY+wJkuicmuZBjoV3bNgQ/CyXHdDU=; b=edqItxPmABZBAwBCNJcaiatCez
        Yos6sgqc2/H2fs9j1EZVC1cljQsOIDgQholquBF4mmdWnOSK/ge0wGRHpe2AomM1+HBr03bsWmETx
        sPHgdBYcjCDnQQiQ0hP9H7DEJxYu+dQ/f2pwwb4aIbsWYYGawFCSifc8kfovg5tb9J/T8DDoptTZT
        v1CIlt3fg3shqjBhbBZtLT0v4K/oaOBZLJV+I9Ttk/cNyWtS360gb89cEqz80/NftLS9qz4iHrUk4
        029O9rovqpGFxRRvNJ9SR8b8m6WzFK7XWHnA9gv6U7eekpd1Zi0czHfVF+VHoaKXQIejCKM4vI51D
        OyYdzRSA==;
Received: from dg by mx.treblig.org with local (Exim 4.89)
        (envelope-from <dg@treblig.org>)
        id 1h3lsL-0008Fq-Ba; Tue, 12 Mar 2019 18:11:41 +0000
Date:   Tue, 12 Mar 2019 18:11:41 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     L A Walsh <lkml@tlinx.org>
Cc:     Karel Zak <kzak@redhat.com>,
        "Dr. David Alan Gilbert" <dave@treblig.org>,
        util-linux@vger.kernel.org
Subject: Re: does util-linux have a 'report sector size' util?
Message-ID: <20190312181141.l3hj2gf5l4dxiniy@gallifrey>
References: <5C86CBA1.40802@tlinx.org>
 <20190311212104.edekhgctqto37tn7@gallifrey>
 <5C86D476.6060807@tlinx.org>
 <20190312082159.jojrjq7ox3d457ke@ws.net.home>
 <5C87CA04.1010308@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C87CA04.1010308@tlinx.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/4.9.0-6-amd64 (x86_64)
X-Uptime: 18:05:46 up 217 days, 23:04,  1 user,  load average: 0.23, 0.17,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

* L A Walsh (lkml@tlinx.org) wrote:
> On 3/12/2019 1:21 AM, Karel Zak wrote:
> > On Mon, Mar 11, 2019 at 02:34:46PM -0700, L A Walsh wrote:
> >   
> >> On 3/11/2019 2:21 PM, Dr. David Alan Gilbert wrote:
> >>     
> >>> * L A Walsh (lkml@tlinx.org) wrote:
> >>>       
> >>>> Trying to track down why my 4K drives no longer display 4K
> >>>> in sysfs (/sys) and don't seem to show individual disk
> >>>> drive information.  When I first got the drives, linux displayed
> >>>> the correct physical disk size, but when I look now, I only
> >>>> see 512.
> >>>>         
> >>> Is this one of the PHY-SEC or LOG-SEC fields that lsblk can print?
> >>>
> >>> [dg@major ~]$ lsblk -o "NAME,PHY-SEC,LOG-SEC"
> >>> NAME                                            PHY-SEC LOG-SEC
> >>> sda                                                 512     512
> >>>       
> >> ---
> >>     It would be, if it was correct.  Megacli displays:
> >>
> >>    Sector Size:  512
> >>    Logical Sector Size:  512
> >>    Physical Sector Size:  4096
> >>
> >> But lsblk displays 512 for everything.  The disk says it uses a 512e format
> >> with the 'e' meaning it emulates 512 even if not 512.
> >>     
> >
> > lsblk, fdisk, blockdev, ... but all of the utils read the information
> > from kernel. So, it depends how the device reports topology to the
> > kernel.
> >   
> Well, that's what I would think but I can't see why the device driver
> would have been purposely changed to hide the actual physical size or
> the temperature.  That said, megacli has to be reading those values
> from somewhere -- and I'd tend to think it was accessing the driver as
> well, but that begs the question -- where is it getting the temperature
> and physical size from>?
> 
> It can even read the serial numbers off the disks.

I think that's an easy one :-)

> I'm not sure if it is opensource or not.
> *sigh*

megacli is a special for LSI RAID controllers isn't it?
If so, then perhaps the RAID controller is hiding some info depending
on how it's configured and using a special to get the info from the controller.

How about trying one of the SCSI utils, like sginfo -a ?

Dave



> 
> >     Karel
> >
> >   
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
