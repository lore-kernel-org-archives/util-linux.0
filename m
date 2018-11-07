Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6470DC0044C
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191A2085B
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 09:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2191A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeKGTTg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:19:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbeKGTTf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Nov 2018 14:19:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26F502D7E5;
        Wed,  7 Nov 2018 09:50:00 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F93360162;
        Wed,  7 Nov 2018 09:49:58 +0000 (UTC)
Date:   Wed, 7 Nov 2018 10:49:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <casantos@datacom.com.br>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.33
Message-ID: <20181107094956.ad56ai463xu262u5@ws.net.home>
References: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
 <20181106123402.cy52t2ql4yvfqme6@function>
 <987477353.537443.1541553608738.JavaMail.zimbra@datacom.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <987477353.537443.1541553608738.JavaMail.zimbra@datacom.com.br>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 07 Nov 2018 09:50:00 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 06, 2018 at 11:20:08PM -0200, Carlos Santos wrote:
> > From: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
> > To: "Karel Zak" <kzak@redhat.com>
> > Cc: "util-linux" <util-linux@vger.kernel.org>
> > Sent: Terça-feira, 6 de novembro de 2018 10:34:02
> > Subject: Re: [ANNOUNCE] util-linux v2.33
> 
> > Hello,
> > 
> > Karel Zak, le mar. 06 nov. 2018 12:33:06 +0100, a ecrit:
> >> The util-linux release v2.33 is available at
> >> 
> >>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33
> >> 
> >> Feedback and bug reports, as always, are welcomed.
> > 
> > It seems new portability issues came in since the rc I tested :)
> > Fix attached.
> > 
> > Samuel
> 
> Could you please explain what portability issues your patch fixes?

The reload agetty feature depends on inotify (netlink, ....). I guess
it's unsupported by GNU Hurd.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
