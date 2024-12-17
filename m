Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0B1F1316
	for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439530; cv=none; b=TZLzv+eyrtGq2EGCTh0IjNiE6Qf+6CO6qeH2zcOs2F9UcXF5Bkum4rYXxvWPxoEmrmVWz32+44XUPSLhVK3Rwp2V+jXQ41j/bXqN2Gbj54sgM6s9H55MwNSHULwHH5riatuE2I69eX0Yo2HYvDsaEuAkjifwWA97EMdzurLGvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439530; c=relaxed/simple;
	bh=uco6QD61KlYjixezS6PHxpnaJJHq5zK4uxweGt8qcJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJpbMHOScCgB6FRpcrnsykV0wEU/jbcoNe0ejroGd9unhrPwPgomePjMhpaPi9CP9cey42dGHks7iKzayAcaq1MpZPphROYyUbIq1hOVBVGv4ZbxaSYN51xz+TM+PGei+iaTBKrlI57JY8y2WwsSHGHlx+xlEYQS4dzITp8ftP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BHLe2VPR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BHLe2VPR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so7644895e9.3
        for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734439526; x=1735044326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm+syrQbdkhIZAIUOI5wx5WW6oa9fvTpJmS5iQkufGY=;
        b=BHLe2VPRvAgLXUvspiTzma5Y9GzcK4ItoOijudslVVl9NAnCLPP1oa4QDLMIv1LgbH
         zqnw5rSEja14+D9RKbunQ7PEmu9/FJdeF4CZd1ZLofwRHEwjaobQwb0AIVzN6s+sJK7y
         J8mmz1pRG4EH2LB3s+y2IVo0NlKNGNGItWp4jArpeLttWUx1KXzWgD3ucSULXJtoffJ+
         bjgo/+9d4z7G83VMw42K+27TV4EVwIcyQyrRaeLamnejoFlkiXGxFgePn5FEi95Gf39J
         n+eBToV6eaffNlcQx1WwmGfZadFwbs/rQozwoAj1O6EPZdTwOH6bwnDPHlOYZLOLIIds
         o4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439526; x=1735044326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm+syrQbdkhIZAIUOI5wx5WW6oa9fvTpJmS5iQkufGY=;
        b=rrCh//sfOxIHtOjUjxJvAcIltUyeVLZAScIckdUcwAaj9Ng0FbHusmzMl+ZdwP/Jpm
         0KYMwqCJNQcv2B4fZY3IH3USD5LHx887nbzuUxJEjc1jwugi4XbqqKf41QQfmoIW5fg2
         ric95jXOqmJC6pLhY0nbbWW89O4TE1M754hmB+DTsg9usbCe9z+31VjKzvxROpwllWGQ
         QYj8rc1Bqm/5zwOlj1Sy67bLCY3ZpNRUf+D8QIbaTIhjPZRs4K/UCsXYHXUgkMcluwDi
         BH3SUS+cJP90cc7p63t97DVwY5tV0ki42pD2/CJlOKCWWIYDaOC7XelRLayzdRD9PJyw
         /Hsw==
X-Forwarded-Encrypted: i=1; AJvYcCVC59+gIJNViPEgV3dfUJU+VWKk/7AhzNxV7lBz5tzIM4U3bBmzYBDP9TmSlTrU+AAj4Z7YWxnS41ec@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhm/9qzFJ5FvfzrSq2/2SHAmHX6NmyS92RoPDi298zbR6y1xjR
	bEdxiyCK6h0KWvd2lfKx38Ud808NkYqIaUCBAwshpqXz0G82O51MV0aHbTPpq12egbPSi9/Xh6w
	UsBk=
X-Gm-Gg: ASbGncs3VzpEJtIpzHqrJ0yNRF1vBuM5e4fegrG4SQ2EYx+dumKJsSxcR023GvwYd2z
	YdHqGhU9qSZbCK9HS5OLln81f/GLnneONaBw0zYiDq/0/1wKsdyA99XIi2dESldhF62I7xUbT3o
	byKWPMWmSVe3Rqm29NVYnxwTAoTsbbxocYDu8gYthmUPT8gx6DdQZZQjGqHBVQQ4CDIyZmdCayA
	JRZj5yuYQ6oh3mdJM0OBH0o81GxQgiS4wdJ+4yKcjL/t9LNFVFgXHWyxMZtYspwHBcuJRJHb2/x
	koHOYreK3iGGV9kSQQoMGETaAQGfZCUqO1XrUQE/2zsj0YzS
X-Google-Smtp-Source: AGHT+IG0KWBhvosH0jsy7AU63ysQ4xowxL0Nz2I0cLYn4hzJT4LMjUmq0cWPbZEzkcrfyi7VW4cc0Q==
X-Received: by 2002:a05:600c:a011:b0:434:ffb2:f9df with SMTP id 5b1f17b1804b1-4362aa40bbcmr156154975e9.17.1734439526507;
        Tue, 17 Dec 2024 04:45:26 -0800 (PST)
Received: from localhost (2001-b011-300c-1872-7e57-58ff-fec7-948b.dynamic-ip6.hinet.net. [2001:b011:300c:1872:7e57:58ff:fec7:948b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ec08sm172407415e9.22.2024.12.17.04.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:45:25 -0800 (PST)
Date: Tue, 17 Dec 2024 20:45:18 +0800
From: Michael Chang <mchang@suse.com>
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Glass Su <glass.su@suse.com>, Heming Zhao <heming.zhao@suse.com>, 
	"linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, grub-devel@gnu.org, util-linux@vger.kernel.org
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
Message-ID: <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u@cc5bu2ij2ia3>
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>

On Tue, Dec 17, 2024 at 11:21:26AM +0100, Zdenek Kabelac wrote:
> Dne 17. 12. 24 v 10:13 Glass Su napsal(a):
> > 
> > > On Dec 17, 2024, at 16:34, Heming Zhao <heming.zhao@suse.com> wrote:
> > > 
> > > Hi LVM2 maintainers,
> > > 
> > > One of SUSE's customers encountered an issue with LVM2. The user created several partitions, one of which was marked as "BIOS boot" (4) instead of "LINUX LVM" (8E). Subsequently, the user ran pvcreate/vgcreate/lvcreate on this partition. During a system update, grub2-install installed GRUB2 in the "BIOS boot" partition, resulting in LVM2 metadata corruption.
> > > 
> > > The root cause of this issue is that grub2-install targets the "BIOS boot" partition when this lvm2 device is specified for installation. If the user had initially marked the partition as "LINUX LVM", grub2-install would not have chosen this partition.
> > > 
> > > On the other hand, it would be beneficial if LVM2 could implement a new filter or a filter function to detect and exclude the "BIOS boot" partition from being considered a valid target for LVM2 device creation. This could involve issuing a warning or error message to alert the user of the potential conflict. This may also help user to notice the issue more easily.
> 
> Hi
> 
> lvm2 is using  blkid to detect 'present' signature on a block device - and
> normally prompt to confirm wiping such signature.
> 
> We may possibly add similar logic for 'partition signatures'.
> 
> However there is still the plain fact that lvm2  with  --force  or even just
> '--yes' option is assumed to simply proceed  and clean&clear such
> conflicting signatures and simply makes the block device to be a PV.
> 
> All that said IMHO primary bug here is within  'grub2-install'  which simply
> should not be blindingly overwriting  block device which is in use - this
> should be fixed ASAP as there is the biggest risk of data loss, although I
> guess everyone is using  'grub2-install --force'  - as without this option
> (even in my personal experience) is typically refusing to do any work....

IMHO, the BIOS Boot partition is dedicated to grub boot code and cannot
be shared with other software. Any attempt other than grub writing to
this area should be prohibited, it should not be the other way around.
Furthermore, adding such check could lead to unexpected failures if the
data is a leftover.

Grub does not write blindly, it checks that the partition is indeed a
BIOS Boot partition before writing to it, as the user is required to
explicitly set the partition type.

For LVM root with legacy BIOS boot, having a BIOS Boot partition is
mandatory, otherwise grub won't have usable space to embed the boot code
in the GPT partition layout, and you won't be able to boot or access a
functional system in the first place. That said, the BIOS Boot partition
is in use by grub before it is mistakenly used to create a PV and extend
the LVM root onto it. It is unlikely that GRUB is overwriting it. In
such cases, it's more likely the other way around.

Thanks,
Michael

> 
> And same applies to most UI tools I've seen that use lvm2 - all seem to be
> pushing  '--force & --yes' with each it emitted lvm2 command...
> 
> Regards
> 
> Zdenek
> 
