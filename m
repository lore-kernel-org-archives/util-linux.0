Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E1C433EF
	for <util-linux@archiver.kernel.org>; Tue, 23 Nov 2021 14:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhKWOno (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234213AbhKWOnn (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Nov 2021 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637678434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPIflkKY0hnfmPBY4HQKKYxAJsywPCsHct7DZTvueLM=;
        b=Pg9SAm5paQap6HlcFJE49SHoOQ+xdWZ1YCu8SNnp7xgCVRBB6eXRuiUD/ewh0uUGAKXYST
        C6ZmvgOftJATkTcA4Vrye1w8B/Ly83GNI+5yjnjshiazA4/zQGzMpW10LdJmYQ1u5/ZODw
        i9nOTWy0/v9HcKMBSk8kLHQ9QrYnDcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-Jzfe2D9xMnmDGgpir1e8HA-1; Tue, 23 Nov 2021 09:40:31 -0500
X-MC-Unique: Jzfe2D9xMnmDGgpir1e8HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A8EA40D3;
        Tue, 23 Nov 2021 14:40:27 +0000 (UTC)
Received: from ws.net.home (ovpn-112-5.ams2.redhat.com [10.36.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF3391981F;
        Tue, 23 Nov 2021 14:40:26 +0000 (UTC)
Date:   Tue, 23 Nov 2021 15:40:23 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>
Subject: Re: [PATCH 4/5] unshare: Add option to automatically create user and
 group maps
Message-ID: <20211123144023.qkhf3xyv4pzihjxc@ws.net.home>
References: <20211117021038.823851-1-seanga2@gmail.com>
 <20211117021038.823851-5-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117021038.823851-5-seanga2@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 16, 2021 at 09:10:37PM -0500, Sean Anderson wrote:
> This option is designed to handle the "garden path" user/group ID
> mapping:
> 
> - The user has one big map in /etc/sub[u,g]id
> - The user wants to map as many user and group IDs as they can,
>   especially the first 1000 users and groups.
> 
> The "auto" map is designed to handle this. We find the first map
> matching the current user, and then map the whole thing to the ID range
> starting at ID 0.

...

>   * map_ids() - Create a new uid/gid map
>   * @idmapper: Either newuidmap or newgidmap
> @@ -571,6 +637,7 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(_(" --map-group=<gid>|<name>  map current group to gid (implies --user)\n"), out);
>  	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
>  	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
> +	fputs(_(" --map-auto                map users and groups automatically (implies --user)\n"), out);
>  	fputs(_(" --map-users=<outeruid>,<inneruid>,<count>\n"
>  		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
>  	fputs(_(" --map-groups=<outergid>,<innergid>,<count>\n"


What about to support "auto" as a placeholder too:

  --map-users=auto
  --map-groups=auto

in this case you can select what you want to map (UID/GID)
automatically.

> +		case OPT_MAPAUTO:
> +			unshare_flags |= CLONE_NEWUSER;
> +			usermap = read_subid_range("/etc/subuid", real_euid);
> +			groupmap = read_subid_range("/etc/subgid", real_egid);
> +			break;

Please, add _PATH_SUBUID and _PATH_SUBGID to include/pathnames.h. We
usually do not use paths in the code.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

