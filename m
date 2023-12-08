Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv8vvP0O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F632171C
	for <util-linux@vger.kernel.org>; Fri,  8 Dec 2023 04:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702038713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNjxn0szJTg5RSj5nNMvNXT3gDCyhiRQpD4m28Mn5WE=;
	b=Uv8vvP0OLshGsWphuygvLNvyNLYfXPQbbShm5YkiMeNG5SQ8ZZozqP9k/IzuwJ/IOpT+iw
	1WAkBalyh9dD4HQ2lasa6qppFAj9DS3IL5tC+fD22yjV25IuHUFy41oJt4VQG3FDkY39st
	2RRmQN3gPzHaSDUHi9es19gI29nVEtk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-Hh6xhpRRNwGQWMAS8t4LhQ-1; Fri,
 08 Dec 2023 07:31:51 -0500
X-MC-Unique: Hh6xhpRRNwGQWMAS8t4LhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B01D29AC03D;
	Fri,  8 Dec 2023 12:31:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CBB358CD3;
	Fri,  8 Dec 2023 12:31:50 +0000 (UTC)
Date: Fri, 8 Dec 2023 13:31:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] more: exit if POLLHUP or POLLERR on stdin is received
Message-ID: <20231208123148.tbo36hrodsoqwln6@ws.net.home>
References: <2eb7rt74ljbdfj2t4psk7qteiwgpab45nyyuzozvy4omxt4xxe@hfbfxuqaeq3x>
 <20231208114519.5kitrxc4goqxolma@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208114519.5kitrxc4goqxolma@ws.net.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, Dec 08, 2023 at 12:45:22PM +0100, Karel Zak wrote:
> On Wed, Dec 06, 2023 at 01:19:17PM -0600, Goldwyn Rodrigues wrote:
> > diff --git a/text-utils/more.c b/text-utils/more.c
> > index d4db3d5eb..6ab9dfe40 100644
> 
> Applied, thanks.
> 

 Reverted. It seems tests/ts/more/regexp fails with the change. For
 example: https://github.com/util-linux/util-linux/actions/runs/7140925530/job/19447184297

 It would be probably better to a create pull-request on GitHub to make
 sure it passes and/or fix the test.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

