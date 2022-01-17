Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139FC433F5
	for <util-linux@archiver.kernel.org>; Mon, 17 Jan 2022 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbiAQQMr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Jan 2022 11:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240901AbiAQQMq (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jan 2022 11:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642435966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7J8BhRWOpoF0zd4Ods4eVYAH+IqZaHR8olaDawewGeM=;
        b=VHIaRhSA9UHqF+0KrEMCunhPe7kWL2F0jgtULJHQjvYEVgtHYNaEoCzb0MFJiCIRPLfe4v
        TFEULTYTGe6eTBgHI8sMXl5OdvF4KD9Tp6GmdMtMzoLm+MuRBsgJPtIgdmjQduvEmq/nV5
        y3tRYBfSitLzXQopmmszy7HwyaqJS6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-xMP74Q34PHGuFaObZEKhKw-1; Mon, 17 Jan 2022 11:12:41 -0500
X-MC-Unique: xMP74Q34PHGuFaObZEKhKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAA1B1898298;
        Mon, 17 Jan 2022 16:12:39 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C554270D5F;
        Mon, 17 Jan 2022 16:12:37 +0000 (UTC)
Date:   Mon, 17 Jan 2022 17:12:35 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20220117161235.caf5sopspyykneww@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
 <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
 <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
 <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
 <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
 <20220117115030.ci5z5jtgyl2clvud@ws.net.home>
 <2ed2e26f-7500-2ddd-a3b3-450f22ef6e67@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed2e26f-7500-2ddd-a3b3-450f22ef6e67@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 17, 2022 at 06:46:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > +{
> > +	ssize_t ssz;
> > +	char buf[PATH_MAX];
> > +	char fdpath[ sizeof(_PATH_PROC_FDDIR) +  sizeof(stringify_value(INT_MAX)) ];
> 
> Extra whitespace after '+'
> 
> Also, I think you should add +1 for '/' (you use it below), and +1 for finishing \0.

sizeof() counts also \0, it means there is space for '/' and '\0'.


Thanks, I'll fix the rest.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

