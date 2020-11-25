Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E5C56202
	for <util-linux@archiver.kernel.org>; Wed, 25 Nov 2020 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F492075A
	for <util-linux@archiver.kernel.org>; Wed, 25 Nov 2020 11:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKEuOmJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKYLVz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgKYLVz (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Nov 2020 06:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606303314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7iZ2o3VT4d3Id7XJLcXhQYCWHNXc4/J92TLZXfZY9Jc=;
        b=CKEuOmJJM50OLR5EDdXbcNFMp7R5iXPSBeuHiDbhyxqaKy/zedqjks4ZVcsK5UNZ1jEA5/
        363+ogC/1ahJOLEUo18nXKaDNPWOoQJLU+qoA9GMmEciamgcSLB2kSsvN5IHf15RNkM11K
        9j/DcJCImUPBHC/vx3aREIseSpJneNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-fmr7WhokNhChPXBeJs-uHA-1; Wed, 25 Nov 2020 06:21:49 -0500
X-MC-Unique: fmr7WhokNhChPXBeJs-uHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD521E7C1
        for <util-linux@vger.kernel.org>; Wed, 25 Nov 2020 11:21:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9423B19D6C;
        Wed, 25 Nov 2020 11:21:47 +0000 (UTC)
Date:   Wed, 25 Nov 2020 12:21:44 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] findmnt: add option to list all statvfs f_flags
Message-ID: <20201125112144.esfpgrfrqbjqr4j3@ws.net.home>
References: <20201125094511.11225-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125094511.11225-1-rbergant@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 25, 2020 at 10:45:11AM +0100, Roberto Bergantinos Corpas wrote:
> It might be useful for security auditing purposes list all possible
> mount flags/options including default set which are normally not listed.
> 
> Given that we already call statvfs to retrieve i.e. filesystem size,
> add an extra column to list all possible f_flags, default or not.

(Sorry Roberto I forgot reply to our private email.)

I understand the goal, but I'm not sure with implementation ;-)

* statvfs() requires access to the mount point, it's better to avoid
  it if possible due to issue with permissions for non-root users and
  due to inaccessible NFS, etc.

  The mount options are already accessible for everyone in /proc/self/mountinfo. 
  It's possible to use mnt_optstr_get_flags() to convert the string
  from mnt_fs_get_vfs_options() to flags.

* your implementation hardcodeds the flags to findmnt.c. This is
  fragile in terms of future development. And for example right now
  your list does not include dirsync, sub, silent, strictatime,
  lazytime, relatime and symfollow options.

  It would be better to use libmount options map where we maintain the
  option flags and strings, something like

     const struct libmnt_optmap *ent;
     const struct libmnt_optmap *map;

     map = mnt_get_builtin_optmap(MNT_LINUX_MAP);

     for (ent = map; ent && ent->name; ent++) {
        if (flags & ent->id)
            ...
     }

 Maybe we can add a function to return all (including default) options
 to libmount to make it easy to use for all applications (something
 like mnt_fs_get_vfs_alloptions()).

> +	[COL_MNT_OPTIONS]  = { "MNT-OPTIONS",  0.20, SCOLS_FL_TRUNC, N_("All statvfs f_flags from mount") },

 Not sure, but do we really need a new column for this purpose?

 It's still about VFS-OPTIONS, the difference is that you need default
 build-in options too. What about to add --vfs-show-default (or so)
 command line options to modify VFS-OPTIONS output?


 I can implement it next week (if you don't want play with
 libmount, etc.).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

