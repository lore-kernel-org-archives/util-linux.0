Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77E4C3F68F
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96423207FD
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580131557;
	bh=ZPH9MRlTF0h8hljNkBEx7e0xwI1cWnk5jj5J5r1QDYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ITCGBVZXaBWL/VN2Pa1U0oNE22pWugEYLUf0tJiVvIsZx/9zH7r6t4f5pYImOrIYz
	 EvU/UkRncoXGx8Irp3p73WBd/Ngf0EGuEvqesIXpiMEbcJTkXOs7yxYvoVbXJcX3mj
	 iwJcDGs5VbgpfgN3jTV+C7Bghx0GYMLUmlECtC20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0NZ5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:25:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33088 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0NZ5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 08:25:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so8569253wmc.0;
        Mon, 27 Jan 2020 05:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iO8Nq5ANy7SDhXxDPNCNJQFw5qpt4WCvMkrabZ+Lf80=;
        b=g3gicgkEXgDLJmhQlkRftA4F73NHVCHBDWdB5XFXTwOmrYWy6VceX2ZG5s4pwkiP7j
         IzWkCNjo9nSUGKahLuqQW4edc79mrn1EXw3lVxlisALeaGsNMiaWHd7XMvKZGv16ZCuW
         CDcAzfo4d/01PkBuHBQ9FYPLp9+MmlycRRRIrqVV62FAJtu+BCi5tKoXwyRvUeosJzTU
         SL/VqmIFaduNkq/a9KQWVG8iO2VwNXwC1tIMXQqN+SO97OPIFxH1QCxXcDFGDjwYclMk
         V4eY5z3af2vpnWg++qZ20hrVenWajklPjxdhl1nAoBA3pxxsdJnDknRulI6N8tcU8GWX
         2QLg==
X-Gm-Message-State: APjAAAUQo23qdLlx/vQ9DeHc3dDQdWS2ii9i6MwGVayj8702vMm3WuWF
        ZqUGaKj3Yl3QV8xVkzKLpBQ=
X-Google-Smtp-Source: APXvYqwNt0V8dd/uQdyi0Gh4XKbuOXu/pspIccoPwyDuO4kgH+ltAOpvYylp25Y3jS0jJtrpAFHGEg==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr14682548wmi.91.1580131554566;
        Mon, 27 Jan 2020 05:25:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n3sm19981965wmc.27.2020.01.27.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:25:53 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:25:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Fontenot, Nathan" <ndfont@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        powerpc-utils-devel@googlegroups.com, util-linux@vger.kernel.org,
        Badari Pulavarty <pbadari@us.ibm.com>,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] drivers/base/memory.c: indicate all memory blocks as
 removable
Message-ID: <20200127132552.GG1183@dhcp22.suse.cz>
References: <20200124155336.17126-1-david@redhat.com>
 <ddb71703-81fa-53fe-51de-c018612f2704@gmail.com>
 <20200127092334.GB1183@dhcp22.suse.cz>
 <d2b3adaa-bd4d-d105-f8ab-0301409bbd5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b3adaa-bd4d-d105-f8ab-0301409bbd5f@redhat.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon 27-01-20 10:33:55, David Hildenbrand wrote:
> On 27.01.20 10:23, Michal Hocko wrote:
> > On Fri 24-01-20 13:10:22, Fontenot, Nathan wrote:
> >> It's been awhile since I've looked at the powerpc-utils drmgr command and
> >> pseries DLPAR code but a quick scan makes and it appears that it hasn't changed
> >> too much. Given that, some thoughts.
> >>
> >> The sysfs 'removable' file was a great help when memory DLPAR was driven
> >> from userspace in the powerpc-utils drmgr command. Having this check did improve
> >> performance though I can't point to any numbers.
> > 
> > Do you still have an access to the HW to give it a try?
> > 
> >> Currently, memory DLPAR is done completely in the kernel. The request is
> >> initiated from drmgr writing to /sys/kernel/dlpar (for pHyp partitions)
> >> or from a hotplug interrupt (for guests). I don't believe the 'removable'
> >> sysfs file is used in either of these paths by drmgr. The only time it is
> >> used is on older kernels that do not support in-kernel memory DLPAR.
> >>
> >> Given this, I don't think removing the 'removable' sysfs file would cause any
> >> issues for the drmgr command. The only scenario I can think of is using an old
> >> version of drmgr that does not support in-kernel memory DLPAR on a new kernel
> >> where the 'removable' sysfs file has been removed. This doesn't seem likely
> >> though and drmgr could be updated to detect this.
> > 
> > Thanks for the information!
> > 
> 
> (weird, I never received the mail from Nathan - mail deliver issues
> brighten my Mondays :) )
> 
> Thanks for the information! Looks like powerpc indeed can live without
> the interface (old userspace on shiny new kernel would in the worst case
> simply be slower).
> 
> Of course, the alternative to returning always "removable" would be to
> drop the attribute completely. So, if the "removable" attribute is not
> present
> 
> - powerpc-utils will fallback to "removable"
> - lsmem will fallback to "not removable". Could be because it assumes
>   "old kernel with lacking offlining capability".
> 
> I don't know how likely it is that this could break custom scripts that
> used the returned value for any purpose (e.g., use it as an indicator if
> memory offlining is supported at all etc.).

Our long term tradition with user visible knobs is to keep them in place
and simply fake the answer. This seems to be a safer option and less
likely to lead to failures.
-- 
Michal Hocko
SUSE Labs
