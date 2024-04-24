Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822415B130
	for <util-linux@vger.kernel.org>; Wed, 24 Apr 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964525; cv=none; b=a/WndoCbtabA3Kx5Ib8i8YwNDE3uvgVYvXf/KxwCL517UzVyKvJYF6zLYsM3UCvspOmLfVP+NnHwL4FaVCRvCebEHSpJUiAYBAdE1uZCj+J5wDMgz66i408PlACA+EXCFVFlHyke/VuArHQNM4FxWMVIyBcW+Sj5Qm8MCtRI37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964525; c=relaxed/simple;
	bh=WYXE6mKy8uDPH2D+xRsO/dcBBca9wM22r/MpjS2XjjI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o34E5DWFflQBazFyPK/VzWlfk55mJ8qP/gMJJKLcQPl2LE3GnReuHK2FIct7MnTvGceHsw9EaQKJeRGqP8G9KIFo5oht1OpXMqwN/TjLm+aZZTQwoAB5j62YyCVl9GSX4ppF+l9Dkp/hmNWv6G01QTFACe5davaQ1r6fOTXijnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIayew2d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIayew2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713964522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJdCWCGiydUVdMxvB3rD2nVFGwQEqFgS7zzoUSDRPJs=;
	b=MIayew2dSiwL6k1Zo6GdFjJS4//9W/cPYOuyn6PZY5jl0hYFGoXdoyG2Nkd9dIgBgjtqfQ
	2a8aW7n5wnEfFBTmRhE4yr71ZvTUQS4hRz3yfDrgB6xAqywJBWQOGiupbTFyDwgW8QlEkd
	YWC1wU8aTelsXQUK3pTNaV0XCaH8du8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-4gupj7WCMymhWmSZJs3DlA-1; Wed, 24 Apr 2024 09:15:19 -0400
X-MC-Unique: 4gupj7WCMymhWmSZJs3DlA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34C1A18065BF;
	Wed, 24 Apr 2024 13:15:19 +0000 (UTC)
Received: from localhost (unknown [10.64.240.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54CBE40F17B;
	Wed, 24 Apr 2024 13:15:18 +0000 (UTC)
Date: Wed, 24 Apr 2024 22:15:17 +0900 (JST)
Message-Id: <20240424.221517.2073047999286647720.yamato@redhat.com>
To: kzak@redhat.com
Cc: paithankarprasanna@gmail.com, util-linux@vger.kernel.org
Subject: Re: [RFC] ipcs for POSIX IPC
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20240424095240.l2fzrswgtvaqpv2o@ws.net.home>
References: <CAOfrUuZ8fL3kz=p2Pwh5JN6Nm9UvE4NPtcikNFCL8LC7r5FW0g@mail.gmail.com>
	<20240424095240.l2fzrswgtvaqpv2o@ws.net.home>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, 24 Apr 2024 11:52:40 +0200, Karel Zak wrote:
> On Wed, Apr 24, 2024 at 04:10:48AM +0530, Prasanna Paithankar wrote:
>> The 'ipcs' (and 'ipcrm') command provides information on (or removes
>> some) System V IPC resources. I'd like to know why no similar utility
>> for POSIX IPC has existed for a long time. I would like to know if
>> such a tool exists in case I missed it. If not, I will provide patches
>> to ipcs and ipcrm (or should I separate the functionality into a new
>> utility).
> 
> I would suggest improving 'lsipc' instead of using the old 'ipcs'.
> 
> The question is where to find information about POSIX IPC. For System
> V, there is /proc/sysvipc, but there is no equivalent for POSIX (or I
> am not aware of it). It seems that the only way to gather this
> information is by scanning all processes' memory maps for /dev/shm.
> This could be achieved by using lsfd.

I read the related man pages:


shm_overview(7) says shm_open(3) may make a file at /dev/shm.
With the following test prgram, I saw it created /dev/shm/X.
    #include <sys/mman.h>
    #include <sys/stat.h>        /* For mode constants */
    #include <fcntl.h>           /* For O_* constants */

    int
    main(void)
    {
	     int fd = shm_open("X", O_CREAT | O_EXCL | O_RDWR, 0600);
	     while (1);
	     return 0;
    }


sem_overview(7) says:

   On  Linux,  named  semaphores are created in a virtual filesystem, nor‐
   mally mounted under /dev/shm, with  names  of  the  form  sem.somename.


As Karel wrote, lsfd can list them if a process do-mmap them.
lsfd doesn't distinguish shm and sem.

mq_overview(7) doesn't say the defatil about the visibility. I inspected the visibility
of mq when addng mq support to lsfd.

The list of mqueue is available if "mqueue" file systems is mounted.
See mqueue_fs_type in ipc/mqueue.c of Linux.
On Fedora, the filesystem is mounted to /dev/mqueue by default. However, some
platforms may not mount it by default.

Here is my idea for listing mqueue:

    for mnt_ns in $all_mnt_ns; do
	if mqueue_fs_is_found_in /proc/mounts; then
	    ls the_mount_point
	else
	   for p in $all_processes; do
	       for fd in $all_fd_in_$p; do
		  if is_mqueue_fd $fd
		     echo the_information_about $fd
		  fi
	       done
	   done | uniq
	fi
    done

lsfd can list mqueues as far as they are opened by processes.
We can use get_minor_for_mqueue and is_mqueue_dev in lsfd-cmd/file.c
when implementing of is_mqueue_fd.

Mounting temporarily the mqueue file system in lsipc is an alternative
way.

Masatake YAMATO

>     Karel
> 
>> 
>> Yours sincerely
>> Prasanna Paithankar
>> 
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
> 

