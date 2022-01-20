Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63EC4332F
	for <util-linux@archiver.kernel.org>; Thu, 20 Jan 2022 09:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbiATJOu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jan 2022 04:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbiATJOt (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Jan 2022 04:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642670089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTPvLXxriUHu//MwI+CcbltwIeGDsk7C00LYsKfm2hI=;
        b=GtKXA0sHG/ecIRpp8SXV2zNih/XEPvwPgiJxmooS+ptSBhdPYSfag9B/3j0yiY5ITgQ2Et
        b5GjJsequz38yHU6i1LwEE9vtgOH+q568X2fj7moY3EvA2qNP6r8Eb58uUCYMHMs5hfIBj
        yZHEsebGk2oHZcecCP26Yq7UUEUB3r0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-AxfMLIA_MZOwyLVy7nB0lA-1; Thu, 20 Jan 2022 04:14:43 -0500
X-MC-Unique: AxfMLIA_MZOwyLVy7nB0lA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0CCD100CCC0;
        Thu, 20 Jan 2022 09:14:41 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E54964D73A;
        Thu, 20 Jan 2022 09:14:39 +0000 (UTC)
Date:   Thu, 20 Jan 2022 10:14:37 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20220120091437.rkohl6kl33it4hwh@ws.net.home>
References: <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
 <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
 <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
 <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
 <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
 <20220117115030.ci5z5jtgyl2clvud@ws.net.home>
 <2ed2e26f-7500-2ddd-a3b3-450f22ef6e67@virtuozzo.com>
 <5db920b8-5df7-d968-5d5c-25d81615ad79@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db920b8-5df7-d968-5d5c-25d81615ad79@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 17, 2022 at 09:10:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> OK, seems that works (I tested the branch topic/blkid-floppy):

 Updated and merged into the master branch. Thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

