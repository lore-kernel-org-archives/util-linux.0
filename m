Return-Path: <SRS0=vZoT=6C=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EEDC2BA19
	for <util-linux@archiver.kernel.org>; Sat, 18 Apr 2020 23:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B89921973
	for <util-linux@archiver.kernel.org>; Sat, 18 Apr 2020 23:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fami-braun.de header.i=@fami-braun.de header.b="GRcgZjSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgDRXFn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 18 Apr 2020 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXFn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 18 Apr 2020 19:05:43 -0400
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831DC061A0C
        for <util-linux@vger.kernel.org>; Sat, 18 Apr 2020 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587251139;
        s=strato-dkim-0002; d=fami-braun.de;
        h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WGc/rCBDl4vbwsLbk4bF8buZ+BykP3l57aF0lIaNYNU=;
        b=GRcgZjStlLPjY9Yhh+ILTbxii6x52/IWDq7/10fBNz9fm7/T7IDndB0Qt+SU/GhxLI
        iuVWDSmlVqcR7MykDF+2gBZ81Cya9YVZkB+0Vtbrn1VVHh/ywSQbKwCqOKOdl+luPUa+
        7/9/gEyTVwKvDWN//JN13WF/KIO15eKEQeXEkk0cnaVVtwojODf0ShtbDu1UlJRYyUO/
        bcCW4bMdCX1lzNrSpmUqyD2FqTsJ1yacvaBeARjGEm5vOf+/AuEPaGdQiNqypeuuxWFt
        NL7fqS20q/pn9lTaljk20Sk6GcJXwF/b3mEd18sSbjuNtATGACli4o2ltx/VOckjVIqC
        lS9g==
X-RZG-AUTH: ":P20JeEWkefDI1ODZs1HHtgV3eF0OpFsRaGIBEm4ljegySSvO7VhbcRIBGrxpcA5nVfJ6oTd1q4jnuxtWZDcOZOKSTOmtb3W8gvPNSUb37NN0EQ=="
X-RZG-CLASS-ID: mo00
Received: from dynamic.fami-braun.de
        by smtp.strato.de (RZmta 46.5.0 AUTH)
        with ESMTPSA id Y04052w3IN5I6ql
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 19 Apr 2020 01:05:18 +0200 (CEST)
Received: from dynamic.fami-braun.de (localhost [127.0.0.1])
        by dynamic.fami-braun.de (fami-braun.de) with ESMTP id 3B8D4154026;
        Sun, 19 Apr 2020 01:05:16 +0200 (CEST)
Received: from MUwn1KzOsXkPj4GHgQEy3QvFhWx/jaeh8kYQFBIT9Qa03xGehiWzwA==
 (6a/hpoGAnTbL0/tmkuZ+MsYXg80CMCsV)
 by webmail.fami-braun.de
 with HTTP (HTTP/1.1 POST); Sun, 19 Apr 2020 01:05:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Apr 2020 01:05:05 +0200
From:   michael-dev <michael-dev@fami-braun.de>
To:     ebiederm@xmission.com
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix PID namespace persistence
In-Reply-To: <87o8rrdulx.fsf@x220.int.ebiederm.org>
References: <20200415211653.5455-1-michael-dev@fami-braun.de>
 <87o8rrdulx.fsf@x220.int.ebiederm.org>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <9379f1f3b13b33e3a80b7cb4a58de8b8@fami-braun.de>
X-Sender: michael-dev@fami-braun.de
X-Virus-Scanned: clamav-milter 0.102.2 at gate
X-Virus-Status: Clean
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Am 16.04.2020 22:49, schrieb ebiederm@xmission.com:
> Why all of the extra code motion and change?
> 
> Your description sounds like only the first hunk is necessary.  Did
> something else get mixed into this change?  Or are all of the hunks
> necessary?

Because after unsharing, pid_for_children is a dangling symlink.
So if (forkit) needs to be before /* wait for bind_ns_files_from_child() 
*/.
Moving this results in an overlapping use of the pid variable, so that 
gets renamed.
Additionally, we cannot wait for the forkit child (bash) to exit before 
triggering and waiting for the bind-mounting child to bind-mount the 
persistent namespace. So forking and waiting for the forkit child (bash) 
needs to become splitted.

Regards,
Michael
