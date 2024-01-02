Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DADDD3
	for <util-linux@vger.kernel.org>; Tue,  2 Jan 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfmmjsK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704191705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nx7jwnzmQ/Q/EaPgiH6e6Gq1vwyj/DUelwWkKAb/1A=;
	b=bfmmjsK8iTq+6uv4YWtv87Eafc44URVgOlMupZPW8SJ2cVzAp2zt/GuvcGPZFfLtg5B3g6
	WeZCBwoNl2YQk3cXJIUO7ohCHTok1LdNinH0KY3yxP7cS2XQ74qpzTz10nFtnc2MD1PI3f
	+Kf6T9pem9y6p7u8GHxy+MoGZhFgMwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-icIJXV22O4mb45OA-9WMZA-1; Tue, 02 Jan 2024 05:35:03 -0500
X-MC-Unique: icIJXV22O4mb45OA-9WMZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 813E9884341;
	Tue,  2 Jan 2024 10:35:03 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA1163C25;
	Tue,  2 Jan 2024 10:35:02 +0000 (UTC)
Date: Tue, 2 Jan 2024 11:35:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Edward Chron <echron@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com, echron@gmail.com
Subject: Re: [PATCH] util-linux-demsg-issue-2666-patch-1.patch
Message-ID: <20240102103500.quej5bcsrocufpny@ws.net.home>
References: <20231231183336.18934-1-echron@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231183336.18934-1-echron@arista.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sun, Dec 31, 2023 at 10:33:36AM -0800, Edward Chron wrote:
> util-linux/sys-utils dmesg add PRINTK_CALLER support
> Submission to Project: util-linux
> Open Incident: #2609 at github.com/util-linux/util-linux/issues/2609
> Component: util-linux/sys-utils
> File: dmesg.c
> Code level patch applied against: 2.39.3 - latest code pulled from
>            git.github.com:util-linux/util-linux.git
> Revision: #1 on 2023/12/08 per Review from Karel Zak
> Revision: #2 on 2023/12/12 Adjust line offsets for master update and
>                            Add caller_id_size init to dmesg -K
> Revision: #3 on 2023/12/12 Use of sizeof for cidbuf and limit search
>                            for caller_id to dmesg prefix to msg text
> Revision: #4 on 2023/12/15 Ensure SYSLOG and kmsg inputs have
>                            caller_id_size set appropriately
> Revision: #5 on 2023/12/24 Make caller_id width consistent with
>                            makedumpfile
> Revision: #6 on 2023/12/30 Use updated test naming convention
>                            Include expected results for new tests

https://github.com/util-linux/util-linux/pull/2647 updated with all
your latest 4 patches.

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

