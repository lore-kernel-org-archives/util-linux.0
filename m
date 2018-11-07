Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29597C0044C
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF720827
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 10:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FF720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKGTcT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:32:19 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:30124
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbeKGTcT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2018 14:32:19 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534802400"; 
   d="scan'208";a="284622000"
Received: from unknown (HELO function) ([193.50.110.180])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2018 11:02:22 +0100
Received: from samy by function with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gKKfF-0006L7-Sj; Wed, 07 Nov 2018 11:02:21 +0100
Date:   Wed, 7 Nov 2018 11:02:21 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Carlos Santos <casantos@datacom.com.br>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.33
Message-ID: <20181107100221.ie4f4oxx7kq32xm7@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Karel Zak <kzak@redhat.com>,
        Carlos Santos <casantos@datacom.com.br>,
        util-linux <util-linux@vger.kernel.org>
References: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
 <20181106123402.cy52t2ql4yvfqme6@function>
 <987477353.537443.1541553608738.JavaMail.zimbra@datacom.com.br>
 <20181107094956.ad56ai463xu262u5@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181107094956.ad56ai463xu262u5@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak, le mer. 07 nov. 2018 10:49:56 +0100, a ecrit:
> On Tue, Nov 06, 2018 at 11:20:08PM -0200, Carlos Santos wrote:
> > > From: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
> > > To: "Karel Zak" <kzak@redhat.com>
> > > Cc: "util-linux" <util-linux@vger.kernel.org>
> > > Sent: Terça-feira, 6 de novembro de 2018 10:34:02
> > > Subject: Re: [ANNOUNCE] util-linux v2.33
> > 
> > > Hello,
> > > 
> > > Karel Zak, le mar. 06 nov. 2018 12:33:06 +0100, a ecrit:
> > >> The util-linux release v2.33 is available at
> > >> 
> > >>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33
> > >> 
> > >> Feedback and bug reports, as always, are welcomed.
> > > 
> > > It seems new portability issues came in since the rc I tested :)
> > > Fix attached.
> > > 
> > > Samuel
> > 
> > Could you please explain what portability issues your patch fixes?
> 
> The reload agetty feature depends on inotify (netlink, ....). I guess
> it's unsupported by GNU Hurd.

Yes, and the #ifdef AGETTY_RELOAD are incoherent: issue_is_changed
accesses fields which are not defined when AGETTY_RELOAD is not defined,
and no_reload is used in pieces of code where AGETTY_RELOAD is not
defined.

Samuel
