Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7892C0F7F
	for <util-linux@vger.kernel.org>; Wed, 25 Feb 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014711; cv=none; b=JZgFpDKbggg2g1CJiR+v/4Zu1jqnEEAZMsG2TU/fFzeUwPHhMK0w6+ivYIkT2gyYgsJ/bDRNrWF38qwUTS42RZsuV4r/POBf0Gt4ICCNcFFjx1zVbvd9RveueNSI2HNEwIX4n7nL+FSWfstSm2IGn+hj4RUmGe/MRD+7ooLUTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014711; c=relaxed/simple;
	bh=E21DsPMTeGg2BcReRXNSt9dpfMyS5Jiimki/NOm9iO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpVC9QclB4FJXjvZdatyuwekoq/6H0hrC+MLgh1b3JdkPHssIZznTjLQhxud0BtIUttwe9mK9j92oNR9wCYPGkrOAWi8cGPBHILpiSQcK1nyOqPVeq+1g4FYhe69uYdftM3onVPLjU2m9ddHOOZitzZV7zGQtmyXdIndLOomdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwwqddrm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwwqddrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772014707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3w0DqSB7dqNcoppScd0RP83KJejGt2rmF0NgiofUloU=;
	b=MwwqddrmfD+yh19LI6Y68hm8iblzdSCVe/KznZLsUEJS3VieE4qCelLLxidt+nxXyytcBo
	tfB1qkt3r3axq1NFHVyEfG8jeNw0BMK8Xs/s59gCQ1IFOZ8rgLVBFmGsH2FJR4i9dJ0uiu
	cfkC53m3L3PCRdp+BumK+CkE6H1IdXk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-FA52cdxYNCWpUsATCz9Nng-1; Wed,
 25 Feb 2026 05:18:25 -0500
X-MC-Unique: FA52cdxYNCWpUsATCz9Nng-1
X-Mimecast-MFC-AGG-ID: FA52cdxYNCWpUsATCz9Nng_1772014704
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1D911955D64;
	Wed, 25 Feb 2026 10:18:12 +0000 (UTC)
Received: from ws (unknown [10.45.224.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 887363003D88;
	Wed, 25 Feb 2026 10:18:11 +0000 (UTC)
Date: Wed, 25 Feb 2026 11:18:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Jonathan Gruber <jonathan.gruber.jg@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Various subsystems: avoid UB from ref counts
Message-ID: <k2q6wmfoky3y2q5pned5j6z2qwzvvasf3sryztldtyyedy4bqb@nm7ije2xytmg>
References: <20260224102329.69255-1-jonathan.gruber.jg@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224102329.69255-1-jonathan.gruber.jg@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


 Hi Jonathan,

I rarely copy and paste from any AI, as I believe it can sometimes be
seen as impolite. However, in this instance, I completely agree with
Claude. See below.

  Karel

I would not merge this. Here's why:

The problem is purely theoretical. Overflowing an int refcount requires ~2 billion live references to
a single object — that's ~16 GB of memory just for the pointers. 

The patch is way too invasive for a non-problem. 31 files, every library, every refcounted type — this
is enormous churn for zero practical benefit. It makes git blame noisy and creates merge conflicts
with any in-flight work.

The identical 6-line comment block is copy-pasted into every _ref() function — that's a lot of
boilerplate explaining something that doesn't need explaining in each location.

Struct layout changes are gratuitous. For example, fdisk_parttype has its members reordered (moving
size_t refcount before code/name). While these are internal structs, pointless layout changes add risk
for no gain.

abort() with no diagnostic message is unfriendly. If the goal is defensive programming, at least print
what happened before crashing.

size_t is an unusual choice for refcounts. It doubles the storage on 64-bit (8 bytes vs 4). unsigned
int would address the UB argument equally well without the size increase. The author's reasoning ("you
can't have SIZE_MAX pointers") applies equally to unsigned int in any realistic scenario.

The <= 0 to == 0 change actually hides bugs. With signed int, if someone double-unrefs, the counter
goes negative and the <= 0 check triggers a (noisy) double-free that tools like ASan catch
immediately. With size_t, a double-unref wraps to SIZE_MAX, the object is never freed, and you get a
silent memory leak — much harder to debug.

Style issue: The #include <stdlib.h> in context.c is placed before #ifdef HAVE_LIBBLKID, outside the
normal include block.

Bottom Line

This is a textbook case of solving a theoretical UB concern with disproportionate real-world cost. The
existing int refcounts have worked fine for years and will continue to work fine. If you wanted to
address this at all, a much smaller approach would be to just add a DBG() assertion in the _ref()
functions, or use unsigned int — but honestly, even that isn't worth the churn.

I'd suggest politely declining the patch.



On Tue, Feb 24, 2026 at 02:23:29AM -0800, Jonathan Gruber wrote:
> util-linux uses type signed int for reference counters. The functions
> that increment reference counters thus risk undefined behavior (UB) if
> the value of the reference counter is INT_MAX prior to the increment,
> because overflow in signed integers is UB. A program that creates more
> than INT_MAX coexistent references to some reference-counted object
> would thus trigger UB by overflowing the reference counter over INT_MAX.
> On systems with size_t larger than int, such as many 64-bit systems, it
> is possible, given sufficient RAM, for a program to create more than
> INT_MAX pointers holding the address of the same reference-counted
> object and to attempt to make each of those pointers be a reference to
> the reference-counted object, thereby overflowing the reference counter
> over INT_MAX and triggering UB. It is best to protect against the
> demonstrated *possibility* of this UB-triggering scenario regardless of
> the scenario's probability.
> 
> While signed integer overflow is UB, it is likely to manifest in this
> scenario as the reference counter wrapping from INT_MAX to INT_MIN.
> However, the functions that decrement the reference counters deallocate
> the reference-counted object if the value of the reference counter
> becomes less than or equal to zero after the decrement. Therefore, if
> the reference counter starts with a value of one and is incremented
> INT_MAX + 2 times with no intervening decrements, then, assuming that
> the resulting integer overflow manifests as a wrap from INT_MAX to
> INT_MIN, the value of the reference counter would become INT_MIN + 2. If
> the reference counter is then decremented once, then its value would
> become INT_MIN + 1, which is less than zero, so the reference-counted
> object would be deallocated even though there are still
> 1 + (INT_MAX + 2) - 1 = INT_MAX + 2 live references to the object. Since
> the object has been deallocated, any access to the remaining references
> would trigger UB. Additionally, if the reference counter is *attempted*
> to be decremented again (which would trigger UB since the
> reference-counted object has been deallocated), then, assuming that the
> memory formerly occupied by the reference-counted object has somehow not
> been reallocated to another object or overwritten, and assuming that the
> UB from the attempted decrement manifests as an actual decrement, the
> "value" of the (deallocated) reference counter would become INT_MIN,
> which is less than zero, so the already-deallocated reference-counted
> object would be deallocated again, resulting in a double free, which
> also triggers UB.
> 
> This patch attempts to address the UB from the reference counters. In
> order to avoid UB from overflowing the reference counters, this patch
> changes the types of the reference counters to an unsigned integer type,
> since overflow for unsigned integer types is not UB but wraps; in this
> case, if the reference counter overflows, then its value would wrap to
> zero. In order to avoid the UB resulting from deallocating the
> reference-counted object when there are still live references to the
> object, this patch ensures that the value of the reference counter is
> zero only if there are actually no live references to the
> reference-counted object. This is done by calling abort() in the
> functions that increment reference counters when the reference counter
> overflows; this behavior is also documented in the documentation
> comments for the functions. The choice to call abort() was made for
> simplicity and because the *least bad* result of accessing a reference
> counted object that has been deallocated too early is for the program to
> crash, which is also what calling abort() triggers. Finally, the
> unsigned integer type that was chosen for the reference counters is
> size_t; this choice minimizes the risk of overflowing the reference
> counter and triggering an abort() because storing more than SIZE_MAX
> coexistent pointers/references to a reference-counted object would
> require more than SIZE_MAX bytes of memory. size_t can be larger than
> int, so this patch might increase the sizes of some reference-counted
> objects, but this increase should be miniscule.
> 
> Signed-off-by: Jonathan Gruber <jonathan.gruber.jg@gmail.com>
> ---
>  include/path.h                |  2 +-
>  lib/path.c                    | 22 +++++++++++++++--
>  libfdisk/src/ask.c            | 18 +++++++++++---
>  libfdisk/src/context.c        | 18 ++++++++++++--
>  libfdisk/src/fdiskP.h         | 15 ++++++------
>  libfdisk/src/item.c           | 16 +++++++++++--
>  libfdisk/src/partition.c      | 19 ++++++++++++---
>  libfdisk/src/parttype.c       | 16 +++++++++++--
>  libfdisk/src/script.c         | 19 ++++++++++++---
>  libfdisk/src/table.c          | 17 +++++++++++--
>  libmount/src/cache.c          | 20 ++++++++++++----
>  libmount/src/fs.c             | 21 ++++++++++++----
>  libmount/src/fs_statmount.c   | 18 +++++++++++---
>  libmount/src/lock.c           | 21 ++++++++++++----
>  libmount/src/monitor.c        | 16 +++++++++++--
>  libmount/src/monitor.h        |  3 ++-
>  libmount/src/mountP.h         | 10 ++++----
>  libmount/src/optlist.c        | 23 ++++++++++++++++--
>  libmount/src/tab.c            | 19 +++++++++++----
>  libsmartcols/src/column.c     | 15 ++++++++++--
>  libsmartcols/src/filter.c     | 34 +++++++++++++++++++++++---
>  libsmartcols/src/grouping.c   | 24 +++++++++++++++++--
>  libsmartcols/src/line.c       | 15 ++++++++++--
>  libsmartcols/src/smartcolsP.h | 18 +++++++-------
>  libsmartcols/src/symbols.c    | 15 ++++++++++--
>  libsmartcols/src/table.c      | 15 ++++++++++--
>  misc-utils/lsblk-devtree.c    | 45 +++++++++++++++++++++++++++++++----
>  misc-utils/lsblk.h            |  4 ++--
>  sys-utils/lscpu-cpu.c         | 23 ++++++++++++++++--
>  sys-utils/lscpu-cputype.c     | 23 +++++++++++++++---
>  sys-utils/lscpu.h             |  5 ++--
>  31 files changed, 454 insertions(+), 95 deletions(-)
> 
> diff --git a/include/path.h b/include/path.h
> index 60a6162df..1b403d66e 100644
> --- a/include/path.h
> +++ b/include/path.h
> @@ -17,7 +17,7 @@ struct path_cxt {
>  	int	dir_fd;
>  	char	*dir_path;
>  
> -	int	refcount;
> +	size_t	refcount;
>  
>  	char *prefix;
>  	char path_buffer[PATH_MAX];
> diff --git a/lib/path.c b/lib/path.c
> index 6ce8a10d2..10aaa7b5c 100644
> --- a/lib/path.c
> +++ b/lib/path.c
> @@ -18,6 +18,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <inttypes.h>
>  #include <errno.h>
>  
> @@ -79,10 +80,27 @@ fail:
>  	return NULL;
>  }
>  
> +/**
> + * ul_ref_path:
> + * @pc: path_cxt instance
> + *
> + * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void ul_ref_path(struct path_cxt *pc)
>  {
> -	if (pc)
> +	if (pc) {
>  		pc->refcount++;
> +		/*
> +		 * pc->refcount == 0 now if and only if
> +		 * pc->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (pc->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  void ul_unref_path(struct path_cxt *pc)
> @@ -92,7 +110,7 @@ void ul_unref_path(struct path_cxt *pc)
>  
>  	pc->refcount--;
>  
> -	if (pc->refcount <= 0) {
> +	if (pc->refcount == 0) {
>  		DBG(CXT, ul_debugobj(pc, "dealloc"));
>  		if (pc->dialect)
>  			pc->free_dialect(pc);
> diff --git a/libfdisk/src/ask.c b/libfdisk/src/ask.c
> index 507cc6fc6..3ce472aa4 100644
> --- a/libfdisk/src/ask.c
> +++ b/libfdisk/src/ask.c
> @@ -3,6 +3,7 @@
>  #include "fdiskP.h"
>  
>  #include <stdarg.h>
> +#include <stdlib.h>
>  
>  /**
>   * SECTION: ask
> @@ -49,7 +50,7 @@ struct fdisk_ask *fdisk_new_ask(void)
>  
>  void fdisk_reset_ask(struct fdisk_ask *ask)
>  {
> -	int refcount;
> +	size_t refcount;
>  
>  	assert(ask);
>  	free(ask->query);
> @@ -69,11 +70,22 @@ void fdisk_reset_ask(struct fdisk_ask *ask)
>   * @ask: ask instance
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void fdisk_ref_ask(struct fdisk_ask *ask)
>  {
> -	if (ask)
> +	if (ask) {
>  		ask->refcount++;
> +		/*
> +		 * ask->refcount == 0 now if and only if
> +		 * ask->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (ask->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  
> @@ -90,7 +102,7 @@ void fdisk_unref_ask(struct fdisk_ask *ask)
>  		return;
>  	ask->refcount--;
>  
> -	if (ask->refcount <= 0) {
> +	if (ask->refcount == 0) {
>  		fdisk_reset_ask(ask);
>  		DBG(ASK, ul_debugobj(ask, "free"));
>  		free(ask);
> diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
> index bc46f1f62..6d8faa8ff 100644
> --- a/libfdisk/src/context.c
> +++ b/libfdisk/src/context.c
> @@ -1,3 +1,6 @@
> +
> +#include <stdlib.h>
> +
>  #ifdef HAVE_LIBBLKID
>  # include <blkid.h>
>  #endif
> @@ -199,11 +202,22 @@ struct fdisk_context *fdisk_new_nested_context(struct fdisk_context *parent,
>   * @cxt: context pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void fdisk_ref_context(struct fdisk_context *cxt)
>  {
> -	if (cxt)
> +	if (cxt) {
>  		cxt->refcount++;
> +		/*
> +		 * ctx->refcount == 0 now if and only if
> +		 * ctx->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (cxt->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -1089,7 +1103,7 @@ void fdisk_unref_context(struct fdisk_context *cxt)
>  		return;
>  
>  	cxt->refcount--;
> -	if (cxt->refcount <= 0) {
> +	if (cxt->refcount == 0) {
>  		DBG(CXT, ul_debugobj(cxt, "freeing context %p for %s", cxt, cxt->dev_path));
>  
>  		reset_context(cxt);	/* this is sensitive to parent<->child relationship! */
> diff --git a/libfdisk/src/fdiskP.h b/libfdisk/src/fdiskP.h
> index e3e57929a..e1af40588 100644
> --- a/libfdisk/src/fdiskP.h
> +++ b/libfdisk/src/fdiskP.h
> @@ -107,12 +107,13 @@ struct fdisk_iter {
>   * Partition types
>   */
>  struct fdisk_parttype {
> -	unsigned int	code;		/* type as number or zero */
> +	size_t		refcount;	/* reference counter for allocated types */
> +
>  	char		*name;		/* description */
>  	char		*typestr;	/* type as string or NULL */
>  
> +	unsigned int	code;		/* type as number or zero */
>  	unsigned int	flags;		/* FDISK_PARTTYPE_* flags */
> -	int		refcount;	/* reference counter for allocated types */
>  };
>  
>  enum {
> @@ -136,7 +137,7 @@ struct fdisk_shortcut {
>  };
>  
>  struct fdisk_partition {
> -	int		refcount;		/* reference counter */
> +	size_t		refcount;		/* reference counter */
>  
>  	size_t		partno;			/* partition number */
>  	size_t		parent_partno;		/* for logical partitions */
> @@ -200,7 +201,7 @@ enum {
>  
>  struct fdisk_table {
>  	struct list_head	parts;		/* partitions */
> -	int			refcount;
> +	size_t			refcount;
>  	size_t			nents;		/* number of partitions */
>  };
>  
> @@ -340,7 +341,7 @@ struct fdisk_ask {
>  	int		type;		/* FDISK_ASKTYPE_* */
>  	char		*query;
>  
> -	int		refcount;
> +	size_t		refcount;
>  
>  	union {
>  		/* FDISK_ASKTYPE_{NUMBER,OFFSET} */
> @@ -384,7 +385,7 @@ struct fdisk_context {
>  	char *dev_model;    /* on linux /sys/block/<name>/device/model or NULL */
>  	struct stat dev_st; /* stat(2) result */
>  
> -	int refcount;
> +	size_t refcount;
>  
>  	unsigned char *firstsector; /* buffer with master boot record */
>  	unsigned long firstsector_bufsz;
> @@ -484,7 +485,7 @@ extern int fdisk_probe_labels(struct fdisk_context *cxt);
>  extern void fdisk_deinit_label(struct fdisk_label *lb);
>  
>  struct fdisk_labelitem {
> -	int		refcount;	/* reference counter */
> +	size_t		refcount;	/* reference counter */
>  	int		id;		/* <label>_ITEM_* */
>  	char		type;		/* s = string, j = uint64 */
>  	const char	*name;		/* human readable name */
> diff --git a/libfdisk/src/item.c b/libfdisk/src/item.c
> index 9e2f44ca1..3c2802c5e 100644
> --- a/libfdisk/src/item.c
> +++ b/libfdisk/src/item.c
> @@ -1,5 +1,6 @@
>  
>  #include <inttypes.h>
> +#include <stdlib.h>
>  
>  #include "fdiskP.h"
>  
> @@ -53,6 +54,8 @@ struct fdisk_labelitem *fdisk_new_labelitem(void)
>   * @li: label item
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + *
>   * Since: 2.29
>   */
>  void fdisk_ref_labelitem(struct fdisk_labelitem *li)
> @@ -61,6 +64,15 @@ void fdisk_ref_labelitem(struct fdisk_labelitem *li)
>  		/* make sure we do not use refcounting for static items */
>  		assert(li->refcount > 0);
>  		li->refcount++;
> +		/*
> +		 * li->refcount == 0 now if and only if
> +		 * li->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (li->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -75,7 +87,7 @@ void fdisk_ref_labelitem(struct fdisk_labelitem *li)
>   */
>  int fdisk_reset_labelitem(struct fdisk_labelitem *li)
>  {
> -	int refcount;
> +	size_t refcount;
>  
>  	if (!li)
>  		return -EINVAL;
> @@ -106,7 +118,7 @@ void fdisk_unref_labelitem(struct fdisk_labelitem *li)
>  	assert(li->refcount > 0);
>  
>  	li->refcount--;
> -	if (li->refcount <= 0) {
> +	if (li->refcount == 0) {
>  		DBG(ITEM, ul_debugobj(li, "free"));
>  		fdisk_reset_labelitem(li);
>  		free(li);
> diff --git a/libfdisk/src/partition.c b/libfdisk/src/partition.c
> index 9a5614d21..0ef16b602 100644
> --- a/libfdisk/src/partition.c
> +++ b/libfdisk/src/partition.c
> @@ -1,4 +1,6 @@
>  
> +#include <stdlib.h>
> +
>  #include "c.h"
>  #include "strutils.h"
>  
> @@ -57,7 +59,7 @@ struct fdisk_partition *fdisk_new_partition(void)
>   */
>  void fdisk_reset_partition(struct fdisk_partition *pa)
>  {
> -	int ref;
> +	size_t ref;
>  
>  	if (!pa)
>  		return;
> @@ -137,11 +139,22 @@ static struct fdisk_partition *__copy_partition(struct fdisk_partition *o)
>   * @pa: partition pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void fdisk_ref_partition(struct fdisk_partition *pa)
>  {
> -	if (pa)
> +	if (pa) {
>  		pa->refcount++;
> +		/*
> +		 * pa->refcount == 0 now if and only if
> +		 * pa->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (pa->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -157,7 +170,7 @@ void fdisk_unref_partition(struct fdisk_partition *pa)
>  		return;
>  
>  	pa->refcount--;
> -	if (pa->refcount <= 0) {
> +	if (pa->refcount == 0) {
>  		list_del(&pa->parts);
>  		fdisk_reset_partition(pa);
>  		DBG(PART, ul_debugobj(pa, "free"));
> diff --git a/libfdisk/src/parttype.c b/libfdisk/src/parttype.c
> index 8e36ada74..026d8ef64 100644
> --- a/libfdisk/src/parttype.c
> +++ b/libfdisk/src/parttype.c
> @@ -1,5 +1,6 @@
>  
>  #include <ctype.h>
> +#include <stdlib.h>
>  
>  #include "fdiskP.h"
>  #include "cctype.h"
> @@ -41,11 +42,22 @@ struct fdisk_parttype *fdisk_new_parttype(void)
>   * @t: partition type
>   *
>   * Increments reference counter for allocated types
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void fdisk_ref_parttype(struct fdisk_parttype *t)
>  {
> -	if (fdisk_parttype_is_allocated(t))
> +	if (fdisk_parttype_is_allocated(t)) {
>  		t->refcount++;
> +		/*
> +		 * t->refcount == 0 now if and only if
> +		 * t->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (t->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -61,7 +73,7 @@ void fdisk_unref_parttype(struct fdisk_parttype *t)
>  		return;
>  
>  	t->refcount--;
> -	if (t->refcount <= 0) {
> +	if (t->refcount == 0) {
>  		DBG(PARTTYPE, ul_debugobj(t, "free"));
>  		free(t->typestr);
>  		free(t->name);
> diff --git a/libfdisk/src/script.c b/libfdisk/src/script.c
> index 62ca5eeb2..6ad1c9261 100644
> --- a/libfdisk/src/script.c
> +++ b/libfdisk/src/script.c
> @@ -1,4 +1,6 @@
>  
> +#include <stdlib.h>
> +
>  #include "cctype.h"
>  #include "fdiskP.h"
>  #include "strutils.h"
> @@ -56,7 +58,7 @@ struct fdisk_script {
>  	struct list_head	headers;
>  	struct fdisk_context	*cxt;
>  
> -	int			refcount;
> +	size_t			refcount;
>  	char			*(*fn_fgets)(struct fdisk_script *, char *, size_t, FILE *);
>  	void			*userdata;
>  
> @@ -158,11 +160,22 @@ done:
>   * @dp: script pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void fdisk_ref_script(struct fdisk_script *dp)
>  {
> -	if (dp)
> +	if (dp) {
>  		dp->refcount++;
> +		/*
> +		 * dp->refcount == 0 now if and only if
> +		 * dp->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (dp->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  static void fdisk_reset_script(struct fdisk_script *dp)
> @@ -195,7 +208,7 @@ void fdisk_unref_script(struct fdisk_script *dp)
>  		return;
>  
>  	dp->refcount--;
> -	if (dp->refcount <= 0) {
> +	if (dp->refcount == 0) {
>  		fdisk_reset_script(dp);
>  		fdisk_unref_context(dp->cxt);
>  		fdisk_unref_table(dp->table);
> diff --git a/libfdisk/src/table.c b/libfdisk/src/table.c
> index 30955e1a6..ea9f26f7e 100644
> --- a/libfdisk/src/table.c
> +++ b/libfdisk/src/table.c
> @@ -1,4 +1,6 @@
>  
> +#include <stdlib.h>
> +
>  #include "fdiskP.h"
>  
>  /**
> @@ -66,11 +68,22 @@ int fdisk_reset_table(struct fdisk_table *tb)
>   * @tb: table pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void fdisk_ref_table(struct fdisk_table *tb)
>  {
> -	if (tb)
> +	if (tb) {
>  		tb->refcount++;
> +		/*
> +		 * tb->refcount == 0 now if and only if
> +		 * tb->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (tb->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -86,7 +99,7 @@ void fdisk_unref_table(struct fdisk_table *tb)
>  		return;
>  
>  	tb->refcount--;
> -	if (tb->refcount <= 0) {
> +	if (tb->refcount == 0) {
>  		fdisk_reset_table(tb);
>  
>  		DBG(TAB, ul_debugobj(tb, "free"));
> diff --git a/libmount/src/cache.c b/libmount/src/cache.c
> index 4d2a20f23..e94c67cf7 100644
> --- a/libmount/src/cache.c
> +++ b/libmount/src/cache.c
> @@ -61,7 +61,7 @@ struct libmnt_cache {
>  	struct mnt_cache_entry	*ents;
>  	size_t			nents;
>  	size_t			nallocs;
> -	int			refcount;
> +	size_t			refcount;
>  	int			probe_sb_extra;	/* extra BLKID_SUBLKS_* flags */
>  
>  	/* blkid_evaluate_tag() works in two ways:
> @@ -126,7 +126,7 @@ void mnt_free_cache(struct libmnt_cache *cache)
>  	if (!cache)
>  		return;
>  
> -	DBG(CACHE, ul_debugobj(cache, "free [refcount=%d]", cache->refcount));
> +	DBG(CACHE, ul_debugobj(cache, "free [refcount=%zu]", cache->refcount));
>  
>  	for (i = 0; i < cache->nents; i++) {
>  		struct mnt_cache_entry *e = &cache->ents[i];
> @@ -145,12 +145,22 @@ void mnt_free_cache(struct libmnt_cache *cache)
>   * @cache: cache pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void mnt_ref_cache(struct libmnt_cache *cache)
>  {
>  	if (cache) {
>  		cache->refcount++;
> -		/*DBG(CACHE, ul_debugobj(cache, "ref=%d", cache->refcount));*/
> +		/*DBG(CACHE, ul_debugobj(cache, "ref=%zu", cache->refcount));*/
> +		/*
> +		 * cache->refcount == 0 now if and only if
> +		 * cache->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (cache->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -165,8 +175,8 @@ void mnt_unref_cache(struct libmnt_cache *cache)
>  {
>  	if (cache) {
>  		cache->refcount--;
> -		/*DBG(CACHE, ul_debugobj(cache, "unref=%d", cache->refcount));*/
> -		if (cache->refcount <= 0) {
> +		/*DBG(CACHE, ul_debugobj(cache, "unref=%zu", cache->refcount));*/
> +		if (cache->refcount == 0) {
>  			mnt_unref_table(cache->mountinfo);
>  
>  			mnt_free_cache(cache);
> diff --git a/libmount/src/fs.c b/libmount/src/fs.c
> index a9b738022..5af562aa8 100644
> --- a/libmount/src/fs.c
> +++ b/libmount/src/fs.c
> @@ -19,6 +19,7 @@
>  #include <ctype.h>
>  #include <blkid.h>
>  #include <stddef.h>
> +#include <stdlib.h>
>  
>  #include "mountP.h"
>  #include "strutils.h"
> @@ -58,7 +59,7 @@ void mnt_free_fs(struct libmnt_fs *fs)
>  	if (!fs)
>  		return;
>  
> -	DBG(FS, ul_debugobj(fs, "free [refcount=%d]", fs->refcount));
> +	DBG(FS, ul_debugobj(fs, "free [refcount=%zu]", fs->refcount));
>  
>  	mnt_reset_fs(fs);
>  	free(fs);
> @@ -72,7 +73,7 @@ void mnt_free_fs(struct libmnt_fs *fs)
>   */
>  void mnt_reset_fs(struct libmnt_fs *fs)
>  {
> -	int ref;
> +	size_t ref;
>  
>  	if (!fs)
>  		return;
> @@ -116,12 +117,22 @@ void mnt_reset_fs(struct libmnt_fs *fs)
>   * @fs: fs pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void mnt_ref_fs(struct libmnt_fs *fs)
>  {
>  	if (fs) {
>  		fs->refcount++;
> -		/*DBG(FS, ul_debugobj(fs, "ref=%d", fs->refcount));*/
> +		/*DBG(FS, ul_debugobj(fs, "ref=%zu", fs->refcount));*/
> +		/*
> +		 * fs->refcount == 0 now if and only if
> +		 * fs->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (fs->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -136,8 +147,8 @@ void mnt_unref_fs(struct libmnt_fs *fs)
>  {
>  	if (fs) {
>  		fs->refcount--;
> -		/*DBG(FS, ul_debugobj(fs, "unref=%d", fs->refcount));*/
> -		if (fs->refcount <= 0)
> +		/*DBG(FS, ul_debugobj(fs, "unref=%zu", fs->refcount));*/
> +		if (fs->refcount == 0)
>  			mnt_free_fs(fs);
>  	}
>  }
> diff --git a/libmount/src/fs_statmount.c b/libmount/src/fs_statmount.c
> index 599ee8c52..a1b1dca53 100644
> --- a/libmount/src/fs_statmount.c
> +++ b/libmount/src/fs_statmount.c
> @@ -15,6 +15,8 @@
>   * @title: statmount setting
>   * @short_description: Fetches information about mount node from the kernel.
>   */
> +#include <stdlib.h>
> +
>  #include "mountP.h"
>  
>  #include "mangle.h"
> @@ -56,12 +58,22 @@ struct libmnt_statmnt *mnt_new_statmnt(void)
>   * @sm: statmount setting
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void mnt_ref_statmnt(struct libmnt_statmnt *sm)
>  {
>  	if (sm) {
>  		sm->refcount++;
> -		/*DBG(STATMNT, ul_debugobj(sm, "ref=%d", sm->refcount));*/
> +		/*DBG(STATMNT, ul_debugobj(sm, "ref=%zu", sm->refcount));*/
> +		/*
> +		 * sm->refcount == 0 now if and only if
> +		 * sm->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (sm->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -76,8 +88,8 @@ void mnt_unref_statmnt(struct libmnt_statmnt *sm)
>  {
>  	if (sm) {
>  		sm->refcount--;
> -		/*DBG(STATMNT, ul_debugobj(sm, "unref=%d", sm->refcount));*/
> -		if (sm->refcount <= 0) {
> +		/*DBG(STATMNT, ul_debugobj(sm, "unref=%zu", sm->refcount));*/
> +		if (sm->refcount == 0) {
>  			free(sm->buf);
>  			free(sm);
>  		}
> diff --git a/libmount/src/lock.c b/libmount/src/lock.c
> index 28ff8b788..b4ec0e3f2 100644
> --- a/libmount/src/lock.c
> +++ b/libmount/src/lock.c
> @@ -25,6 +25,7 @@
>  #include <fcntl.h>
>  #include <limits.h>
>  #include <sys/file.h>
> +#include <stdlib.h>
>  
>  #include "strutils.h"
>  #include "closestream.h"
> @@ -36,7 +37,7 @@
>   * lock handler
>   */
>  struct libmnt_lock {
> -	int	refcount;	/* reference counter */
> +	size_t	refcount;	/* reference counter */
>  	char	*lockfile;	/* path to lock file (e.g. /etc/mtab~) */
>  	int	lockfile_fd;	/* lock file descriptor */
>  
> @@ -101,7 +102,7 @@ void mnt_free_lock(struct libmnt_lock *ml)
>  	if (!ml)
>  		return;
>  
> -	DBG(LOCKS, ul_debugobj(ml, "free%s [refcount=%d]",
> +	DBG(LOCKS, ul_debugobj(ml, "free%s [refcount=%zu]",
>  					ml->locked ? " !!! LOCKED !!!" : "",
>  					ml->refcount));
>  	free(ml->lockfile);
> @@ -113,6 +114,7 @@ void mnt_free_lock(struct libmnt_lock *ml)
>   * @ml: lock pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   *
>   * Since: 2.40
>   */
> @@ -120,7 +122,16 @@ void mnt_ref_lock(struct libmnt_lock *ml)
>  {
>  	if (ml) {
>  		ml->refcount++;
> -		/*DBG(FS, ul_debugobj(fs, "ref=%d", ml->refcount));*/
> +		/*DBG(FS, ul_debugobj(fs, "ref=%zu", ml->refcount));*/
> +		/*
> +		 * ml->refcount == 0 now if and only if
> +		 * ml->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (ml->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -135,8 +146,8 @@ void mnt_unref_lock(struct libmnt_lock *ml)
>  {
>  	if (ml) {
>  		ml->refcount--;
> -		/*DBG(FS, ul_debugobj(fs, "unref=%d", ml->refcount));*/
> -		if (ml->refcount <= 0)
> +		/*DBG(FS, ul_debugobj(fs, "unref=%zu", ml->refcount));*/
> +		if (ml->refcount == 0)
>  			mnt_free_lock(ml);
>  	}
>  }
> diff --git a/libmount/src/monitor.c b/libmount/src/monitor.c
> index 194817aac..35c70857b 100644
> --- a/libmount/src/monitor.c
> +++ b/libmount/src/monitor.c
> @@ -38,6 +38,7 @@
>  #include "mountP.h"
>  #include "monitor.h"
>  
> +#include <stdlib.h>
>  #include <sys/epoll.h>
>  
>  /**
> @@ -67,11 +68,22 @@ struct libmnt_monitor *mnt_new_monitor(void)
>   * @mn: monitor pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void mnt_ref_monitor(struct libmnt_monitor *mn)
>  {
> -	if (mn)
> +	if (mn) {
>  		mn->refcount++;
> +		/*
> +		 * mn->refcount == 0 now if and only if
> +		 * mn->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (mn->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  void free_monitor_entry(struct monitor_entry *me)
> @@ -102,7 +114,7 @@ void mnt_unref_monitor(struct libmnt_monitor *mn)
>  		return;
>  
>  	mn->refcount--;
> -	if (mn->refcount <= 0) {
> +	if (mn->refcount == 0) {
>  		mnt_monitor_close_fd(mn);	/* destroys all file descriptors */
>  
>  		while (!list_empty(&mn->ents)) {
> diff --git a/libmount/src/monitor.h b/libmount/src/monitor.h
> index a7859c075..b17b271be 100644
> --- a/libmount/src/monitor.h
> +++ b/libmount/src/monitor.h
> @@ -6,6 +6,7 @@
>  
>  #include "c.h"
>  #include <stdbool.h>
> +#include <stddef.h>
>  
>  struct monitor_opers;
>  
> @@ -26,7 +27,7 @@ struct monitor_entry {
>  };
>  
>  struct libmnt_monitor {
> -	int			refcount;
> +	size_t			refcount;
>  	int			fd;		/* public monitor file descriptor */
>  
>  	struct list_head	ents;
> diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
> index 7a6a4fbe2..41dee526f 100644
> --- a/libmount/src/mountP.h
> +++ b/libmount/src/mountP.h
> @@ -205,13 +205,13 @@ struct libmnt_iter {
>   * statmount setting; shared between tables and filesystems
>   */
>  struct libmnt_statmnt {
> -	int             refcount;
> -	uint64_t        mask;           /* default statmount() mask */
> +	size_t		refcount;
> +	uint64_t	mask;           /* default statmount() mask */
>  
>  	struct ul_statmount *buf;
>  	size_t bufsiz;
>  
> -	unsigned int    disabled: 1;    /* enable or disable statmount() */
> +	unsigned int	disabled: 1;    /* enable or disable statmount() */
>  };
>  
>  
> @@ -223,7 +223,7 @@ struct libmnt_fs {
>  	struct list_head ents;
>  	struct libmnt_table *tab;
>  
> -	int		refcount;	/* reference counter */
> +	size_t		refcount;	/* reference counter */
>  
>  	unsigned int	opts_age;	/* to sync with optlist */
>  	struct libmnt_optlist *optlist;
> @@ -322,7 +322,7 @@ static inline void mnt_fs_mark_moved(struct libmnt_fs *fs)
>  struct libmnt_table {
>  	int		fmt;		/* MNT_FMT_* file format */
>  	int		nents;		/* number of entries */
> -	int		refcount;	/* reference counter */
> +	size_t		refcount;	/* reference counter */
>  	int		comms;		/* enable/disable comment parsing */
>  	char		*comm_intro;	/* First comment in file */
>  	char		*comm_tail;	/* Last comment in file */
> diff --git a/libmount/src/optlist.c b/libmount/src/optlist.c
> index 5bb32c6a8..0b6f6cd19 100644
> --- a/libmount/src/optlist.c
> +++ b/libmount/src/optlist.c
> @@ -13,6 +13,8 @@
>   * The "optlist" is container for parsed mount options.
>   *
>   */
> +#include <stdlib.h>
> +
>  #include "strutils.h"
>  #include "list.h"
>  #include "mountP.h"
> @@ -51,7 +53,7 @@ struct libmnt_opt {
>  };
>  
>  struct libmnt_optlist {
> -	int refcount;
> +	size_t refcount;
>  	unsigned int age;			/* incremented after each change */
>  
>  	const struct libmnt_optmap	*linux_map;	/* map with MS_ flags */
> @@ -90,10 +92,27 @@ struct libmnt_optlist *mnt_new_optlist(void)
>  	return ls;
>  }
>  
> +/**
> + * mnt_ref_optlist:
> + * @ls: optlist instance
> + *
> + * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void mnt_ref_optlist(struct libmnt_optlist *ls)
>  {
> -	if (ls)
> +	if (ls) {
>  		ls->refcount++;
> +		/*
> +		 * ls->refcount == 0 now if and only if
> +		 * ls->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (ls->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  static void reset_cache(struct optlist_cache *cache)
> diff --git a/libmount/src/tab.c b/libmount/src/tab.c
> index 0d2b0ecd4..903cad522 100644
> --- a/libmount/src/tab.c
> +++ b/libmount/src/tab.c
> @@ -48,6 +48,7 @@
>   * will return the first entry (if UUID matches with the device).
>   */
>  #include <blkid.h>
> +#include <stdlib.h>
>  
>  #include "mountP.h"
>  #include "strutils.h"
> @@ -126,12 +127,22 @@ int mnt_reset_table(struct libmnt_table *tb)
>   * @tb: table pointer
>   *
>   * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void mnt_ref_table(struct libmnt_table *tb)
>  {
>  	if (tb) {
>  		tb->refcount++;
> -		/*DBG(FS, ul_debugobj(tb, "ref=%d", tb->refcount));*/
> +		/*DBG(FS, ul_debugobj(tb, "ref=%zu", tb->refcount));*/
> +		/*
> +		 * tb->refcount == 0 now if and only if
> +		 * tb->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (tb->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -146,8 +157,8 @@ void mnt_unref_table(struct libmnt_table *tb)
>  {
>  	if (tb) {
>  		tb->refcount--;
> -		/*DBG(FS, ul_debugobj(tb, "unref=%d", tb->refcount));*/
> -		if (tb->refcount <= 0)
> +		/*DBG(FS, ul_debugobj(tb, "unref=%zu", tb->refcount));*/
> +		if (tb->refcount == 0)
>  			mnt_free_table(tb);
>  	}
>  }
> @@ -169,7 +180,7 @@ void mnt_free_table(struct libmnt_table *tb)
>  		return;
>  
>  	mnt_reset_table(tb);
> -	DBG(TAB, ul_debugobj(tb, "free [refcount=%d]", tb->refcount));
> +	DBG(TAB, ul_debugobj(tb, "free [refcount=%zu]", tb->refcount));
>  
>  	mnt_unref_cache(tb->cache);
>  	free(tb->comm_intro);
> diff --git a/libsmartcols/src/column.c b/libsmartcols/src/column.c
> index a36e54690..f29475db2 100644
> --- a/libsmartcols/src/column.c
> +++ b/libsmartcols/src/column.c
> @@ -51,11 +51,22 @@ struct libscols_column *scols_new_column(void)
>   * @cl: a pointer to a struct libscols_column instance
>   *
>   * Increases the refcount of @cl.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void scols_ref_column(struct libscols_column *cl)
>  {
> -	if (cl)
> +	if (cl) {
>  		cl->refcount++;
> +		/*
> +		 * cl->refcount == 0 now if and only if
> +		 * cl->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (cl->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -67,7 +78,7 @@ void scols_ref_column(struct libscols_column *cl)
>   */
>  void scols_unref_column(struct libscols_column *cl)
>  {
> -	if (cl && --cl->refcount <= 0) {
> +	if (cl && --cl->refcount == 0) {
>  		DBG(COL, ul_debugobj(cl, "dealloc"));
>  		list_del(&cl->cl_columns);
>  		scols_reset_cell(&cl->header);
> diff --git a/libsmartcols/src/filter.c b/libsmartcols/src/filter.c
> index 4923cd802..a9254d9cd 100644
> --- a/libsmartcols/src/filter.c
> +++ b/libsmartcols/src/filter.c
> @@ -60,13 +60,24 @@ struct libscols_filter *scols_new_filter(const char *str)
>   * @fltr: filter instance
>   *
>   * Increment filter reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   *
>   * Since: 2.40
>   */
>  void scols_ref_filter(struct libscols_filter *fltr)
>  {
> -	if (fltr)
> +	if (fltr) {
>  		fltr->refcount++;
> +		/*
> +		 * fltr->refcount == 0 now if and only if
> +		 * fltr->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (fltr->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  static void reset_filter(struct libscols_filter *fltr)
> @@ -112,7 +123,7 @@ static void remove_counters(struct libscols_filter *fltr)
>   */
>  void scols_unref_filter(struct libscols_filter *fltr)
>  {
> -	if (fltr && --fltr->refcount <= 0) {
> +	if (fltr && --fltr->refcount == 0) {
>  		DBG(FLTR, ul_debugobj(fltr, "dealloc"));
>  		reset_filter(fltr);
>  		remove_counters(fltr);
> @@ -149,10 +160,27 @@ void filter_unref_node(struct filter_node *n)
>  	}
>  }
>  
> +/**
> + * filter_ref_node:
> + * @n: filter_node instance
> + *
> + * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void filter_ref_node(struct filter_node *n)
>  {
> -	if (n)
> +	if (n) {
>  		n->refcount++;
> +		/*
> +		 * n->refcount == 0 now if and only if
> +		 * n->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (n->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  void filter_dump_node(struct ul_jsonwrt *json, struct filter_node *n)
> diff --git a/libsmartcols/src/grouping.c b/libsmartcols/src/grouping.c
> index 7e004b647..7445a7fb4 100644
> --- a/libsmartcols/src/grouping.c
> +++ b/libsmartcols/src/grouping.c
> @@ -1,6 +1,8 @@
>  /*
>   * Copyright (C) 2018 Karel Zak <kzak@redhat.com>
>   */
> +#include <stdlib.h>
> +
>  #include "smartcolsP.h"
>  
>  /**
> @@ -15,10 +17,28 @@
>   */
>  
>  /* Private API */
> +
> +/**
> + * scols_ref_group:
> + * @gr: group instance
> + *
> + * Increments reference counter.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void scols_ref_group(struct libscols_group *gr)
>  {
> -	if (gr)
> +	if (gr) {
>  		gr->refcount++;
> +		/*
> +		 * gr->refcount == 0 now if and only if
> +		 * gr->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (gr->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  void scols_group_remove_children(struct libscols_group *gr)
> @@ -61,7 +81,7 @@ void scols_group_remove_members(struct libscols_group *gr)
>  /* note group has to be already without members to deallocate */
>  void scols_unref_group(struct libscols_group *gr)
>  {
> -	if (gr && --gr->refcount <= 0) {
> +	if (gr && --gr->refcount == 0) {
>  		DBG(GROUP, ul_debugobj(gr, "dealloc"));
>  		scols_group_remove_children(gr);
>  		list_del(&gr->gr_groups);
> diff --git a/libsmartcols/src/line.c b/libsmartcols/src/line.c
> index ffefcfba0..7789ed3aa 100644
> --- a/libsmartcols/src/line.c
> +++ b/libsmartcols/src/line.c
> @@ -56,11 +56,22 @@ struct libscols_line *scols_new_line(void)
>   * @ln: a pointer to a struct libscols_line instance
>   *
>   * Increases the refcount of @ln.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void scols_ref_line(struct libscols_line *ln)
>  {
> -	if (ln)
> +	if (ln) {
>  		ln->refcount++;
> +		/*
> +		 * ln->refcount == 0 now if and only if
> +		 * ln->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (ln->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -72,7 +83,7 @@ void scols_ref_line(struct libscols_line *ln)
>   */
>  void scols_unref_line(struct libscols_line *ln)
>  {
> -	if (ln && --ln->refcount <= 0) {
> +	if (ln && --ln->refcount == 0) {
>  		DBG(CELL, ul_debugobj(ln, "dealloc"));
>  		list_del(&ln->ln_lines);
>  		list_del(&ln->ln_children);
> diff --git a/libsmartcols/src/smartcolsP.h b/libsmartcols/src/smartcolsP.h
> index 1e9dcec01..8e6e92d09 100644
> --- a/libsmartcols/src/smartcolsP.h
> +++ b/libsmartcols/src/smartcolsP.h
> @@ -61,7 +61,7 @@ struct libscols_iter {
>   * Tree symbols
>   */
>  struct libscols_symbols {
> -	int	refcount;
> +	size_t	refcount;
>  
>  	char	*tree_branch;
>  	char	*tree_vert;
> @@ -69,7 +69,7 @@ struct libscols_symbols {
>  
>  	char	*group_vert;
>  	char	*group_horz;
> -	char    *group_first_member;
> +	char	*group_first_member;
>  	char	*group_last_member;
>  	char	*group_middle_member;
>  	char	*group_last_child;
> @@ -111,7 +111,7 @@ struct libscols_wstat {
>   * Table column
>   */
>  struct libscols_column {
> -	int	refcount;	/* reference counter */
> +	size_t	refcount;	/* reference counter */
>  	size_t	seqnum;		/* column index */
>  
>  	size_t	width;		/* expected column width */
> @@ -182,9 +182,9 @@ enum {
>  #define SCOLS_GRPSET_CHUNKSIZ	3
>  
>  struct libscols_group {
> -	int     refcount;
> +	size_t	refcount;
>  
> -	size_t  nmembers;
> +	size_t	nmembers;
>  
>  	struct list_head gr_members;	/* head of line->ln_group */
>  	struct list_head gr_children;	/* head of line->ln_children */
> @@ -197,7 +197,7 @@ struct libscols_group {
>   * Table line
>   */
>  struct libscols_line {
> -	int	refcount;
> +	size_t	refcount;
>  	size_t	seqnum;
>  
>  	void	*userdata;
> @@ -227,7 +227,7 @@ enum {
>   * The table
>   */
>  struct libscols_table {
> -	int	refcount;
> +	size_t	refcount;
>  	char	*name;		/* optional table name (for JSON) */
>  	size_t	ncols;		/* number of columns */
>  	size_t  ntreecols;	/* number of columns with SCOLS_FL_TREE */
> @@ -527,7 +527,7 @@ enum filter_etype {
>  
>  struct filter_node {
>  	enum filter_ntype type;
> -	int refcount;
> +	size_t refcount;
>  };
>  
>  #define filter_node_get_type(n)	(((struct filter_node *)(n))->type)
> @@ -549,7 +549,7 @@ struct libscols_counter {
>  };
>  
>  struct libscols_filter {
> -	int refcount;
> +	size_t refcount;
>  	char *errmsg;
>  	struct filter_node *root;
>  	FILE *src;
> diff --git a/libsmartcols/src/symbols.c b/libsmartcols/src/symbols.c
> index 2fadfc7ad..9acb62fa3 100644
> --- a/libsmartcols/src/symbols.c
> +++ b/libsmartcols/src/symbols.c
> @@ -43,11 +43,22 @@ struct libscols_symbols *scols_new_symbols(void)
>   * @sy: a pointer to a struct libscols_symbols instance
>   *
>   * Increases the refcount of @sy.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void scols_ref_symbols(struct libscols_symbols *sy)
>  {
> -	if (sy)
> +	if (sy) {
>  		sy->refcount++;
> +		/*
> +		 * sy->refcount == 0 now if and only if
> +		 * sy->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (sy->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /**
> @@ -58,7 +69,7 @@ void scols_ref_symbols(struct libscols_symbols *sy)
>   */
>  void scols_unref_symbols(struct libscols_symbols *sy)
>  {
> -	if (sy && --sy->refcount <= 0) {
> +	if (sy && --sy->refcount == 0) {
>  		free(sy->tree_branch);
>  		free(sy->tree_vert);
>  		free(sy->tree_right);
> diff --git a/libsmartcols/src/table.c b/libsmartcols/src/table.c
> index aa7cdf3c6..9d60519e5 100644
> --- a/libsmartcols/src/table.c
> +++ b/libsmartcols/src/table.c
> @@ -96,11 +96,22 @@ struct libscols_table *scols_new_table(void)
>   * @tb: a pointer to a struct libscols_table instance
>   *
>   * Increases the refcount of @tb.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
>   */
>  void scols_ref_table(struct libscols_table *tb)
>  {
> -	if (tb)
> +	if (tb) {
>  		tb->refcount++;
> +		/*
> +		 * tb->refcount == 0 now if and only if
> +		 * tb->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (tb->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  static void scols_table_remove_groups(struct libscols_table *tb)
> @@ -123,7 +134,7 @@ static void scols_table_remove_groups(struct libscols_table *tb)
>   */
>  void scols_unref_table(struct libscols_table *tb)
>  {
> -	if (tb && (--tb->refcount <= 0)) {
> +	if (tb && (--tb->refcount == 0)) {
>  		DBG(TAB, ul_debugobj(tb, "dealloc <-"));
>  		scols_table_remove_groups(tb);
>  		scols_table_remove_lines(tb);
> diff --git a/misc-utils/lsblk-devtree.c b/misc-utils/lsblk-devtree.c
> index 5e9d38da1..1736c82ed 100644
> --- a/misc-utils/lsblk-devtree.c
> +++ b/misc-utils/lsblk-devtree.c
> @@ -16,11 +16,12 @@
>   *
>   * Copyright (C) 2018 Karel Zak <kzak@redhat.com>
>   */
> +#include <stdlib.h>
> +
>  #include "lsblk.h"
>  #include "sysfs.h"
>  #include "pathnames.h"
>  
> -
>  void lsblk_reset_iter(struct lsblk_iter *itr, int direction)
>  {
>  	if (direction == -1)
> @@ -51,10 +52,27 @@ struct lsblk_device *lsblk_new_device(void)
>  	return dev;
>  }
>  
> +/**
> + * lsblk_ref_device:
> + * @dev: a pointer to a struct lsblk_device instance
> + *
> + * Increments the refcount of @dev.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void lsblk_ref_device(struct lsblk_device *dev)
>  {
> -	if (dev)
> +	if (dev) {
>  		dev->refcount++;
> +		/*
> +		 * dev->refcount == 0 now if and only if
> +		 * dev->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (dev->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  /* removes dependence from child as well as from parent */
> @@ -101,7 +119,7 @@ void lsblk_unref_device(struct lsblk_device *dev)
>  	if (!dev)
>  		return;
>  
> -	if (--dev->refcount <= 0) {
> +	if (--dev->refcount == 0) {
>  		DBG(DEV, ul_debugobj(dev, " freeing [%s] <<", dev->name));
>  
>  		device_remove_dependences(dev);
> @@ -251,10 +269,27 @@ struct lsblk_devtree *lsblk_new_devtree(void)
>  	return tr;
>  }
>  
> +/**
> + * lsblk_ref_devtree:
> + * @tr: a pointer to a struct lsblk_devtree instance
> + *
> + * Increments the refcount of @tr.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void lsblk_ref_devtree(struct lsblk_devtree *tr)
>  {
> -	if (tr)
> +	if (tr) {
>  		tr->refcount++;
> +		/*
> +		 * tr->refcount == 0 now if and only if
> +		 * tr->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (tr->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  void lsblk_unref_devtree(struct lsblk_devtree *tr)
> @@ -262,7 +297,7 @@ void lsblk_unref_devtree(struct lsblk_devtree *tr)
>  	if (!tr)
>  		return;
>  
> -	if (--tr->refcount <= 0) {
> +	if (--tr->refcount == 0) {
>  		DBG(TREE, ul_debugobj(tr, "dealloc"));
>  
>  		while (!list_empty(&tr->devices)) {
> diff --git a/misc-utils/lsblk.h b/misc-utils/lsblk.h
> index 90d2df1a1..f51949ec0 100644
> --- a/misc-utils/lsblk.h
> +++ b/misc-utils/lsblk.h
> @@ -124,7 +124,7 @@ struct lsblk_devdep {
>  };
>  
>  struct lsblk_device {
> -	int	refcount;
> +	size_t	refcount;
>  
>  	struct list_head	childs;		/* list with lsblk_devdep */
>  	struct list_head	parents;
> @@ -193,7 +193,7 @@ struct lsblk_devnomap {
>   *    md0 -> sda1 -> sda
>   */
>  struct lsblk_devtree {
> -	int	refcount;
> +	size_t	refcount;
>  
>  	struct list_head	roots;		/* tree root devices */
>  	struct list_head	devices;	/* all devices */
> diff --git a/sys-utils/lscpu-cpu.c b/sys-utils/lscpu-cpu.c
> index 0619e7d34..1f306bb5d 100644
> --- a/sys-utils/lscpu-cpu.c
> +++ b/sys-utils/lscpu-cpu.c
> @@ -8,6 +8,8 @@
>   *
>   * Copyright (C) 2020 Karel Zak <kzak@redhat.com>
>   */
> +#include <stdlib.h>
> +
>  #include "lscpu.h"
>  
>  struct lscpu_cpu *lscpu_new_cpu(int id)
> @@ -28,10 +30,27 @@ struct lscpu_cpu *lscpu_new_cpu(int id)
>  	return cpu;
>  }
>  
> +/**
> + * lscpu_ref_cpu:
> + * @cpu: a pointer to a struct lscpu_cpu instance
> + *
> + * Increments the refcount of @cpu.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void lscpu_ref_cpu(struct lscpu_cpu *cpu)
>  {
> -	if (cpu)
> +	if (cpu) {
>  		cpu->refcount++;
> +		/*
> +		 * cpu->refcount == 0 now if and only if
> +		 * cpu->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (cpu->refcount == 0)
> +			abort();
> +	}
>  }
>  
>  void lscpu_unref_cpu(struct lscpu_cpu *cpu)
> @@ -39,7 +58,7 @@ void lscpu_unref_cpu(struct lscpu_cpu *cpu)
>  	if (!cpu)
>  		return;
>  
> -	if (--cpu->refcount <= 0) {
> +	if (--cpu->refcount == 0) {
>  		DBG(CPU, ul_debugobj(cpu, "  freeing #%d", cpu->logical_id));
>  		lscpu_unref_cputype(cpu->type);
>  		cpu->type = NULL;
> diff --git a/sys-utils/lscpu-cputype.c b/sys-utils/lscpu-cputype.c
> index 958cbe7b6..9dffb8df9 100644
> --- a/sys-utils/lscpu-cputype.c
> +++ b/sys-utils/lscpu-cputype.c
> @@ -8,6 +8,7 @@
>   *
>   * Copyright (C) 2020 Karel Zak <kzak@redhat.com>
>   */
> +#include <stdlib.h>
>  #include <sys/utsname.h>
>  #include <sys/personality.h>
>  
> @@ -69,11 +70,27 @@ struct lscpu_cputype *lscpu_new_cputype(void)
>  	return ct;
>  }
>  
> +/**
> + * lscpu_ref_cputype:
> + * @ct: a pointer to a struct lscpu_cputype instance
> + *
> + * Increments the refcount of @ct.
> + * Calls abort() if reference counter equals SIZE_MAX prior to the increment.
> + */
>  void lscpu_ref_cputype(struct lscpu_cputype *ct)
>  {
>  	if (ct) {
>  		ct->refcount++;
> -		/*DBG(TYPE, ul_debugobj(ct, ">>> ref %d", ct->refcount));*/
> +		/*DBG(TYPE, ul_debugobj(ct, ">>> ref %zu", ct->refcount));*/
> +		/*
> +		 * ct->refcount == 0 now if and only if
> +		 * ct->refcount == SIZE_MAX prior to the increment.
> +		 *
> +		 * Checking for overflow after the increment instead of before
> +		 * seems to generate better assembly.
> +		 */
> +		if (ct->refcount == 0)
> +			abort();
>  	}
>  }
>  
> @@ -82,9 +99,9 @@ void lscpu_unref_cputype(struct lscpu_cputype *ct)
>  	if (!ct)
>  		return;
>  
> -	/*DBG(TYPE, ul_debugobj(ct, ">>> unref %d", ct->refcount - 1));*/
> +	/*DBG(TYPE, ul_debugobj(ct, ">>> unref %zu", ct->refcount - 1));*/
>  
> -	if (--ct->refcount <= 0) {
> +	if (--ct->refcount == 0) {
>  		DBG(TYPE, ul_debugobj(ct, "  freeing %s/%s", ct->vendor, ct->model));
>  		lscpu_cputype_free_topology(ct);
>  		free(ct->vendor);
> diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
> index 0fae5d29e..5f5a0315a 100644
> --- a/sys-utils/lscpu.h
> +++ b/sys-utils/lscpu.h
> @@ -13,6 +13,7 @@
>  #define LSCPU_H
>  
>  #include <stdbool.h>
> +#include <stddef.h>
>  
>  #include "c.h"
>  #include "nls.h"
> @@ -67,7 +68,7 @@ struct lscpu_cache {
>  };
>  
>  struct lscpu_cputype {
> -	int	refcount;
> +	size_t	refcount;
>  
>  	char	*vendor;
>  	int	vendor_id;	/* created by lscpu_decode_arm() */
> @@ -137,7 +138,7 @@ enum {
>  };
>  
>  struct lscpu_cpu {
> -	int refcount;
> +	size_t refcount;
>  	struct lscpu_cputype *type;
>  
>  	int logical_id;
> -- 
> 2.53.0
> 
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

