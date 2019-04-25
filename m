Return-Path: <SRS0=oRo1=S3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE82CC43218
	for <util-linux@archiver.kernel.org>; Thu, 25 Apr 2019 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F5020652
	for <util-linux@archiver.kernel.org>; Thu, 25 Apr 2019 17:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDYRCe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:02:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36908 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRCd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 25 Apr 2019 13:02:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id e2so165660qtb.4
        for <util-linux@vger.kernel.org>; Thu, 25 Apr 2019 10:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=x+jpAuPAGlFiSiQ8d2loDQCUGdlzGfe40YYNJOgp3Ww=;
        b=sj9TVRqmHYFTYqeqBrv/KgWj9WHHY2ZIDhvPyMuUxdcXSa3HfXsV/PLs/1ZK/y2Vf9
         Rf1FKsgYejIzz4dIONqFW+YEJOmZDpdaDKtj9tXGiJDbXC0zK+XNJIOBiJIRPyH0x3ky
         2Te01UXn4SzA21Usd+9hzV42bAUH1VtQugISSUrVSNYdT+mmdmOh9ydgXGiW78sjLooL
         akkkzyTOIe267sl0/0PPIBsWRl+t2QOJfXkGF7aTSgkaVrfR8t8ak0scK5h6W/EIbZQx
         p+ayLJJT9v9othmNavbqDABWC785Sjbl+xLJxe6E/PaEw9+oQBjQeLc/QPf9MC6dwtIe
         n1YQ==
X-Gm-Message-State: APjAAAWr4dFsIUfFR6Aa3PHe0ExhXS2TD8gGkbd5eOgUU4UmFjYFNpv8
        kZ73JuaI0GCigVthWdmQRB1wMw==
X-Google-Smtp-Source: APXvYqyaOLiUA1dCMQqZ715atKqlWbKITSwL9xmLiUGVtVhuRUCqeislGHWMqam2NiFqi5ZmTZHhxA==
X-Received: by 2002:aed:20c4:: with SMTP id 62mr30379468qtb.256.1556211752441;
        Thu, 25 Apr 2019 10:02:32 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-202A-0-0-0-83B.dyn6.twc.com. [2606:a000:1100:202a::83b])
        by smtp.gmail.com with ESMTPSA id s193sm4748161qke.4.2019.04.25.10.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:02:31 -0700 (PDT)
Message-ID: <8d8bb81a1d0299395ec6c75a86d4ce0e7d6a53c6.camel@redhat.com>
Subject: Re: [PATCH 00/10] exposing knfsd opens to userspace
From:   Jeff Layton <jlayton@redhat.com>
To:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, abe@purdue.edu,
        lsof-l@lists.purdue.edu, util-linux@vger.kernel.org
Date:   Thu, 25 Apr 2019 13:02:30 -0400
In-Reply-To: <1556201060-7947-1-git-send-email-bfields@redhat.com>
References: <1556201060-7947-1-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 2019-04-25 at 10:04 -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> The following patches expose information about NFSv4 opens held by knfsd
> on behalf of NFSv4 clients.  Those are currently invisible to userspace,
> unlike locks (/proc/locks) and local proccesses' opens (/proc/<pid>/).
> 
> The approach is to add a new directory /proc/fs/nfsd/clients/ with
> subdirectories for each active NFSv4 client.  Each subdirectory has an
> "info" file with some basic information to help identify the client and
> an "opens" directory that lists the opens held by that client.
> 
> I got it working by cobbling together some poorly-understood code I
> found in libfs, rpc_pipefs and elsewhere.  If anyone wants to wade in
> and tell me what I've got wrong, they're more than welcome, but at this
> stage I'm more curious for feedback on the interface.
> 
> I'm also cc'ing people responsible for lsof and util-linux in case they
> have any opinions.
> 
> Currently these pseudofiles look like:
> 
>   # find /proc/fs/nfsd/clients -type f|xargs tail 
>   ==> /proc/fs/nfsd/clients/3741/opens <==
>   5cc0cd36/6debfb50/00000001/00000001	rw	--	fd:10:13649	'open id:\x00\x00\x00&\x00\x00\x00\x00\x00\x00\x0b\xb7\x89%\xfc\xef'
>   5cc0cd36/6debfb50/00000003/00000001	r-	--	fd:10:13650	'open id:\x00\x00\x00&\x00\x00\x00\x00\x00\x00\x0b\xb7\x89%\xfc\xef'
> 
>   ==> /proc/fs/nfsd/clients/3741/info <==
>   clientid: 6debfb505cc0cd36
>   address: 192.168.122.36:0
>   name: Linux NFSv4.2 test2.fieldses.org
>   minor version: 2
> 
> Each line of the "opens" file is tab-delimited and describes one open,
> and the fields are stateid, open access bits, deny bits,
> major:minor:ino, and open owner.
> 

Nice work! We've needed this for a long time.

One thing we need to consider here from the get-go though is what sort
of ABI guarantee you want for this format. People _will_ write scripts
that scrape this info, so we should take that into account up front.


> So, some random questions:
> 
> 	- I just copied the major:minor:ino thing from /proc/locks, I
> 	  suspect we would have picked something different to identify
> 	  inodes if /proc/locks were done now.  (Mount id and inode?
> 	  Something else?)
> 

That does make it easy to correlate with the info in /proc/locks.

We'd have a dentry here by virtue of the nfs4_file. Should we print a
path in addition to this?

> 	- The open owner is just an opaque blob of binary data, but
> 	  clients may choose to include some useful asci-encoded
> 	  information, so I'm formatting them as strings with non-ascii
> 	  stuff escaped.  For example, pynfs usually uses the name of
> 	  the test as the open owner.  But as you see above, the ascii
> 	  content of the Linux client's open owners is less useful.
> 	  Also, there's no way I know of to map them back to a file
> 	  description or process or anything else useful on the client,
> 	  so perhaps they're of limited interest.
> 
> 	- I'm not sure about the stateid either.  I did think it might
> 	  be useful just as a unique identifier for each line.
> 	  (Actually for that it'd be enough to take just the third of
> 	  those four numbers making up the stateid--maybe that would be
> 	  better.)
> 

It'd be ideal to be able to easily correlate this info with what
wireshark displays. Does wireshark display hashes for openowners? I know
it does for stateids. If so, generating the same hash would be really
nice.

That said, waybe it's best to just dump the raw info out here though and
rely on some postprocessing scripts for viewing it?

> In the "info" file, the "name" line is the client identifier/client
> owner provided by the client, which (like the stateowner) is just opaque
> binary data, though as you can see here the Linux client is providing a
> readable ascii string.
> 
> There's probably a lot more we could add to that info file eventually.
> 
> Other stuff to add next:
> 
> 	- nfsd/clients/#/kill that you can write to to revoke all a
> 	  client's state if it's wedged somehow.

That would also be neat. We have a bit of code to support today that in
the fault injection code, but it'll need some cleanup and wiring it into
a knob here would be better.

> 	- lists of locks and delegations; lower priority since most of
> 	  that information is already in /proc/locks.

Agreed.

> J. Bruce Fields (10):
>   nfsd: persist nfsd filesystem across mounts
>   nfsd: rename cl_refcount
>   nfsd4: use reference count to free client
>   nfsd: add nfsd/clients directory
>   nfsd: make client/ directory names small ints
>   rpc: replace rpc_filelist by tree_descr
>   nfsd4: add a client info file
>   nfsd4: add file to display list of client's opens
>   nfsd: expose some more information about NFSv4 opens
>   nfsd: add more information to client info file
> 
>  fs/nfsd/netns.h                |   6 +
>  fs/nfsd/nfs4state.c            | 228 ++++++++++++++++++++++++++++++---
>  fs/nfsd/nfsctl.c               | 225 +++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsd.h                 |  11 ++
>  fs/nfsd/state.h                |   9 +-
>  fs/seq_file.c                  |  17 +++
>  include/linux/seq_file.h       |   2 +
>  include/linux/string_helpers.h |   1 +
>  lib/string_helpers.c           |   5 +-
>  net/sunrpc/rpc_pipe.c          |  37 ++----
>  10 files changed, 491 insertions(+), 50 deletions(-)
> 

-- 
Jeff Layton <jlayton@redhat.com>

