Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB7C56202
	for <util-linux@archiver.kernel.org>; Wed, 25 Nov 2020 11:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3663920679
	for <util-linux@archiver.kernel.org>; Wed, 25 Nov 2020 11:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtEkPGF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKYL3w (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbgKYL3w (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Nov 2020 06:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606303790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3tJjl1en+Tw/oXWXTlRLdYVjSpu1yBJAlDJkXPhAJ4=;
        b=UtEkPGF18jr1nYvOvm3k/G6x0kLpW6S85aQXx2yBrRgwvT2Dt9LULKXS0zUn72KkLs6B7W
        mckdBNp92r5VdvK/m+avmSRQ+7U0qLzQTvLDCkGJWpI9aoHJzImg9OPSEgCkCcSm0pOg89
        fPlGlOGUP65G1zits0WKG4HmG+0Chwk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-LvrexsCeNwCm0m9-i66HRw-1; Wed, 25 Nov 2020 06:29:47 -0500
X-MC-Unique: LvrexsCeNwCm0m9-i66HRw-1
Received: by mail-il1-f199.google.com with SMTP id g125so1465650ilh.6
        for <util-linux@vger.kernel.org>; Wed, 25 Nov 2020 03:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3tJjl1en+Tw/oXWXTlRLdYVjSpu1yBJAlDJkXPhAJ4=;
        b=iD12ZqLZrz1rNhW1IrusCRz2RlVaE5DuyrZT0dtZRmBeJyzbevciwK7hfgrB4oS2eY
         AtjibQUuHhUr3/dcZiUO/I++AyvLo2gmkSDX13QJ0jlAM4+UFdt/IUyHB3gARNhWXkjY
         1/w+exuar7ocKcAO9iGXV/LNRpsG7IVF/MwZWVG7EE0gOHT0urJQOd6r8190R6hGtYhE
         JLTl3Q2RrelrsuDg81WiJ5+ei/NKkw/VIXgW65lsuBNU1LY+3u0MGkgfXz92nYhBxlRc
         jn0nOInBTnjahA+kfg90KAhKNEfrHjkwZy3wK3TMJad/ozq3Db5IEqbfJ/Qo9sKZ8QII
         vq4w==
X-Gm-Message-State: AOAM532T7iH73/JaT582/ImS5xwQNVZTCpZbu/SJgM/DBMkgxDEiCiCV
        bj/JKKr2uqzvgPnx1s2kbc30JZWR2QxThncLuSLn6lpdjtYa8pNMb9PeLiLypq4+XQkEg5Nt//8
        Z1CxH8DcqLPp/dr2KGS5rnfK5KQZSDg9mK66r/Q==
X-Received: by 2002:a92:8707:: with SMTP id m7mr2352715ild.217.1606303787083;
        Wed, 25 Nov 2020 03:29:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznA3g8Eli2J7xQzSAxu66mtmOnGBSg57WiHIjpiIWSLCIsJyhxA8EDhtf3MbHZTaMXZGIQGPAoRwPGLRvVXCw=
X-Received: by 2002:a92:8707:: with SMTP id m7mr2352700ild.217.1606303786794;
 Wed, 25 Nov 2020 03:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20201125094511.11225-1-rbergant@redhat.com> <20201125112144.esfpgrfrqbjqr4j3@ws.net.home>
In-Reply-To: <20201125112144.esfpgrfrqbjqr4j3@ws.net.home>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Wed, 25 Nov 2020 12:29:33 +0100
Message-ID: <CACWnjLxT74u=zgYKY3=bQLssOjPC+ZxmV82O=sNwWJ6CePyuig@mail.gmail.com>
Subject: Re: [PATCH] findmnt: add option to list all statvfs f_flags
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel!

thanks for inputs, appreciate it.

Yes i agree with your objections, in fact first i thought about
extending VFS-OPTIONS via some flag,
and check agains options map, thought i guess i took easy path at some point ;-)

I'll try to see if i can make some work based on your suggestions
before next week.

On Wed, Nov 25, 2020 at 12:21 PM Karel Zak <kzak@redhat.com> wrote:
>
> On Wed, Nov 25, 2020 at 10:45:11AM +0100, Roberto Bergantinos Corpas wrote:
> > It might be useful for security auditing purposes list all possible
> > mount flags/options including default set which are normally not listed.
> >
> > Given that we already call statvfs to retrieve i.e. filesystem size,
> > add an extra column to list all possible f_flags, default or not.
>
> (Sorry Roberto I forgot reply to our private email.)
>
> I understand the goal, but I'm not sure with implementation ;-)
>
> * statvfs() requires access to the mount point, it's better to avoid
>   it if possible due to issue with permissions for non-root users and
>   due to inaccessible NFS, etc.
>
>   The mount options are already accessible for everyone in /proc/self/mountinfo.
>   It's possible to use mnt_optstr_get_flags() to convert the string
>   from mnt_fs_get_vfs_options() to flags.
>
> * your implementation hardcodeds the flags to findmnt.c. This is
>   fragile in terms of future development. And for example right now
>   your list does not include dirsync, sub, silent, strictatime,
>   lazytime, relatime and symfollow options.
>
>   It would be better to use libmount options map where we maintain the
>   option flags and strings, something like
>
>      const struct libmnt_optmap *ent;
>      const struct libmnt_optmap *map;
>
>      map = mnt_get_builtin_optmap(MNT_LINUX_MAP);
>
>      for (ent = map; ent && ent->name; ent++) {
>         if (flags & ent->id)
>             ...
>      }
>
>  Maybe we can add a function to return all (including default) options
>  to libmount to make it easy to use for all applications (something
>  like mnt_fs_get_vfs_alloptions()).
>
> > +     [COL_MNT_OPTIONS]  = { "MNT-OPTIONS",  0.20, SCOLS_FL_TRUNC, N_("All statvfs f_flags from mount") },
>
>  Not sure, but do we really need a new column for this purpose?
>
>  It's still about VFS-OPTIONS, the difference is that you need default
>  build-in options too. What about to add --vfs-show-default (or so)
>  command line options to modify VFS-OPTIONS output?
>
>
>  I can implement it next week (if you don't want play with
>  libmount, etc.).
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

