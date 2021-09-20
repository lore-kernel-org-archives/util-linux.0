Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB441C433EF
	for <util-linux@archiver.kernel.org>; Mon, 20 Sep 2021 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05DE60F6D
	for <util-linux@archiver.kernel.org>; Mon, 20 Sep 2021 09:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhITKAO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 20 Sep 2021 06:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235419AbhITKAM (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Sep 2021 06:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632131925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFuEo1diEdgsuLT3bHgTyR9nZoyD/3ubvWDPTGFCr6c=;
        b=Kt11pHnvOX0yOyP3oxgMilu7GEyK5zC+UfftbEBZdefdza8tpz0RcEw7qr6bK9CV0FU5r3
        LXsr2NAZIenlyBz9QR8+cjAI0ypg7e/uxp2RYz24R3vSl2dHAyFPxKW1yMEM6XsNJ/2xDd
        MqXW3spsBgkT4lteWoHgfnci2hI45OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-KmAJLs_GNSKYiqhJeaVgQQ-1; Mon, 20 Sep 2021 05:58:44 -0400
X-MC-Unique: KmAJLs_GNSKYiqhJeaVgQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 235ED835DE0;
        Mon, 20 Sep 2021 09:58:43 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B75B5D9DC;
        Mon, 20 Sep 2021 09:58:42 +0000 (UTC)
Date:   Mon, 20 Sep 2021 11:58:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Eli V <eliventer@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Would be nice if lsblk combined multipath disks
Message-ID: <20210920095839.3fbd7pwugh7fvcyh@ws.net.home>
References: <CAJtFHUTWt02hsfqpcDmaw2F+trWwm4yjBZO0FK_jpxX-4QhcSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJtFHUTWt02hsfqpcDmaw2F+trWwm4yjBZO0FK_jpxX-4QhcSQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Sep 17, 2021 at 10:19:22AM -0400, Eli V wrote:
> lsblk is awesome for viewing a system's storage stack. However, it
> would be great if it just spit out the list of devices sharing a
> multipath name instead of repeating the full tree for each device.
> lsblk -i from version 2.29.2, only one tree shown but the exact same
> tree appears under sdai as well on my example host.
> 
> sdce                             69:32   0 838.4G  0 disk
> `-mpathal                       254:44   0 838.4G  0 mpath
>   `-md1                           9:1    0     9T  0 raid10
>     `-cryptmd1                  254:55   0     9T  0 crypt
>       |-cryptdbv-dbthin_tmeta   254:56   0   2.8G  0 lvm
>       | `-cryptdbv-dbthin-tpool 254:58   0    15T  0 lvm
>       |   |-cryptdbv-dbthin     254:59   0    15T  0 lvm
>       |   `-cryptdbv-pg         254:60   0    15T  0 lvm    /var/lib/postgresql
>       `-cryptdbv-dbthin_tdata   254:57   0    15T  0 lvm
>         `-cryptdbv-dbthin-tpool 254:58   0    15T  0 lvm
>           |-cryptdbv-dbthin     254:59   0    15T  0 lvm
>           `-cryptdbv-pg         254:60   0    15T  0 lvm    /var/lib/postgresql


In this cases --merge usually helps (if there is defined relation by
kernel; e.g. DM thin), or you can use --dedup (for example to
de-duplicate by WWN).

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

