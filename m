Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482EC4332F
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 14:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiBAOZa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:25:30 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44954 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239241AbiBAOZ2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 09:25:28 -0500
X-IronPort-AV: E=Sophos;i="5.88,334,1635199200"; 
   d="scan'208";a="19104415"
Received: from nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr (HELO begin) ([194.199.1.52])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:25:27 +0100
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1nEu63-009Ya5-JL;
        Tue, 01 Feb 2022 15:25:27 +0100
Date:   Tue, 1 Feb 2022 15:25:27 +0100
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220201142527.6v5xpwuryenz2k4q@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20220131151432.mfk62bwskotc6w64@ws.net.home>
 <20220131182030.ci3q6puznrwt6vst@begin>
 <20220201141430.sscfssbebyg3kzjq@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201141430.sscfssbebyg3kzjq@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak, le mar. 01 févr. 2022 15:14:30 +0100, a ecrit:
> On Mon, Jan 31, 2022 at 07:20:30PM +0100, Samuel Thibault wrote:
> > Karel Zak, le lun. 31 janv. 2022 16:14:32 +0100, a ecrit:
> > > The util-linux release v2.38-rc1 is available at
> > >      
> > >   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
> > 
> > Thanks, here are a few non-Linux portability fixes
> 
> Applied with minor changes, thanks!

Works fine, thanks!

Samuel
