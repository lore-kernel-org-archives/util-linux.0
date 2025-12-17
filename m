Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C912BF000
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995985; cv=none; b=CDX26B+uUCirP8z3osMlhpV1gpozvzK1YVi7f0miEJ7LcV7vtLNa/ewrtWURlUB+HtJhnZHLUCgy51fzDZXM4V1PDddOj/I6XbWsDWBnSsLJkPeoGnnZ1I9zYIiLiOlm0FQAKvwkceqcD/srWpVPXoptQ6WAQfWxadw7GHlBdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995985; c=relaxed/simple;
	bh=HR6JP2IMTzJMk+8nmqgF2G/T0Fv4lZiEphXia2o7l84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FD4c0uKOdMuVMPhAyOxAHs0HpfMu5VvtjzmoxBV4VGLZYSSIu6PK6st45butEn6Y0fJuXZlaJl3h7/vVcXSbPmKgKFQyXnohp4xwNDJBz4KbhrLtqbAn/ZdoJtLemXgmn+cYMqkIv2XMhdMftS+q0ZXdrk4D1YBkE726JY78tPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMjguqeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMjguqeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765995980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcAtJtT+CmOOGWcbvIWXAllLYruJa4pW5eUesCmcya0=;
	b=fMjguqegNUACFkNMSDRx8ia70hPECMwsG9E/OKLiQrlfZhj8caNDVioDbEvFpw2moThJav
	E9uKqZpi+j8B4Q+ukZGNWe2y2JrU0X5PZLgXAvxPnzEgKsQZiim4iyGNyH91eKXCEEd5b8
	4pwS64HWBd2Iz+qx3i6+3kpIHPwNazY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-iKNtNY8bPV-Sd6_Yzg2lNg-1; Wed,
 17 Dec 2025 13:26:12 -0500
X-MC-Unique: iKNtNY8bPV-Sd6_Yzg2lNg-1
X-Mimecast-MFC-AGG-ID: iKNtNY8bPV-Sd6_Yzg2lNg_1765995971
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69FD51800621;
	Wed, 17 Dec 2025 18:26:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA18130001A2;
	Wed, 17 Dec 2025 18:26:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: kwolf@redhat.com,
	hare@suse.de,
	Karel Zak <kzak@redhat.com>,
	pizhenwei@bytedance.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/3] blkpr: prepare for _IOR() ioctls
Date: Wed, 17 Dec 2025 13:26:05 -0500
Message-ID: <20251217182607.179232-2-stefanha@redhat.com>
In-Reply-To: <20251217182607.179232-1-stefanha@redhat.com>
References: <20251217182607.179232-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

parse_pr_command() returns the ioctl command constant for a given
command or -1 when the command is unknown. Up until now all ioctl
command constants were positive, so the following check worked:

  if (command < 0)
      err(EXIT_FAILURE, _("unknown command"));

The top two bits of ioctl command constants encode the direction (_IO,
_IOR, _IOW, _IOWR). ioctl commands defined with _IOR have negative ioctl
command constants.

Explicitly check for -1 to differentiate "unknown command" from valid
ioctls commands. Later commits will add ioctl commands that use _IOR.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 sys-utils/blkpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index 03ca9f7e5..c6b030def 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -276,7 +276,7 @@ int main(int argc, char **argv)
 			break;
 		case 'c':
 			command = parse_pr_command(optarg);
-			if (command < 0)
+			if (command == -1)
 				err(EXIT_FAILURE, _("unknown command"));
 			break;
 		case 't':
-- 
2.52.0

