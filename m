Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF0DDD6
	for <util-linux@vger.kernel.org>; Mon, 15 Jan 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYHDFrAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705311640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWo8vn4N1N+56fje69jcWFUwb0dlt7lFtfHRgImkMKM=;
	b=LYHDFrAJo65qF5j5X6dupHKybwIxLL+mWLnMHk62yJq6aJBgDJ1xjj9t9tUYb+1zFM/rz9
	vk1dMD+/5UMiv2lzswZkAuP/XSWcG/QAgdqIaynssxHvE1yrrGKlZx/5/jcTFwLurZuqPV
	y9UGl5u0W/qPXpqW4UfeTp3IW6SnCfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-LrfNMW9hPDi71Bpco6zgmw-1; Mon, 15 Jan 2024 04:40:37 -0500
X-MC-Unique: LrfNMW9hPDi71Bpco6zgmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F67B811E9E;
	Mon, 15 Jan 2024 09:40:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 920891121306;
	Mon, 15 Jan 2024 09:40:36 +0000 (UTC)
Date: Mon, 15 Jan 2024 10:40:34 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fdisk_deassign_device: only sync(2) blockdevs
Message-ID: <20240115094034.2anrtva3yf6hoshf@ws.net.home>
References: <utso6yacwbluj5pou2vwllxfb5dxmhbly5qaumlshga3o5fbgg@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <utso6yacwbluj5pou2vwllxfb5dxmhbly5qaumlshga3o5fbgg@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sat, Jan 13, 2024 at 11:35:31PM +0100, наб wrote:
> When not editing a blockdev, syncing disks provides no benefit
> (we already fsync() above), takes a long time,
> and affects unrelated caches.
> 
> BLKRRPART is similarly gated on !S_ISBLK(st_mode) in
> fdisk_reread_partition_table.

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

