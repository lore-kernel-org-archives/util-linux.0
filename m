Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6Kr1TS4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CBA4
	for <util-linux@vger.kernel.org>; Tue,  5 Dec 2023 02:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701772044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMXZ5xF+1jWYz7PEzNkHanNg6z7+FrKYoEm+rDz1YNI=;
	b=E6Kr1TS4mOTyMw6FXgd4nxqpqUL7TZsZVtvpcObK2rrmWlGuunnux4gwFz9wk/Bri85sP2
	mUm9iBp8t2UQPQo9BNj3t0bgsnqC8MU4XbeKVm/UsVuatpaI/sqNs6MJ1hrFX/EFN/XIBc
	N5KOC2+KvwAJI33c7D1YSKtS6VK0wK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-g23_WxW_OYah5Ieq_Sf18g-1; Tue, 05 Dec 2023 05:27:19 -0500
X-MC-Unique: g23_WxW_OYah5Ieq_Sf18g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CE4A8A51C2;
	Tue,  5 Dec 2023 10:27:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A0FB3C25;
	Tue,  5 Dec 2023 10:27:18 +0000 (UTC)
Date: Tue, 5 Dec 2023 11:27:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] increase delay for waitpid test
Message-ID: <20231205102717.g3puawoit7ykjjku@ws.net.home>
References: <n26ts5nhsyoj2xbpxkhwcsq3tslz2nao6ef57tkkcj6ve7zxhv@4423dzinkagw>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n26ts5nhsyoj2xbpxkhwcsq3tslz2nao6ef57tkkcj6ve7zxhv@4423dzinkagw>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Nov 29, 2023 at 11:36:23AM -0600, Goldwyn Rodrigues wrote:
> diff --git a/tests/ts/misc/waitpid b/tests/ts/misc/waitpid
> --- a/tests/ts/misc/waitpid
> +++ b/tests/ts/misc/waitpid
> @@ -24,7 +24,7 @@ ts_check_test_command "$TS_CMD_WAITPID"
>  
>  ts_init_subtest normal
>  
> -(sleep 0.2; echo 1 >> "$TS_OUTPUT") &
> +(sleep 0.5; echo 1 >> "$TS_OUTPUT") &

Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

