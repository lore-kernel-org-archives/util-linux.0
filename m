Return-Path: dave@gnu.org
Subject: Re: [PATCH] lists: add list sorting routine
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1323730346.2536.3.camel@offbook>
References: <1323730346.2536.3.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Dec 2011 23:55:57 +0100
Message-ID: <1323730557.2536.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

One note: the code is added to the header file instead of its own C file
so we don't have to update all the build rules of the list.h users.

Thanks,
Davidlohr

On Mon, 2011-12-12 at 23:52 +0100, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> We need a list sorting function, just to mention one example user that could benefit is the lib/tt code to sort columns.
> 
> This patch adds list_sort() which uses the Merge Sort algorithm, behaving nicely in O(nlog(n)), heavily based on the kernel's implementation[1].
> The private data (void *priv) passed to the comparison function as been removed to adopt a qsort(3)-like syntax, and IMHO we don't really need it anyways.
> 
> [1]: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=lib/list_sort.c;h=d7325c6b103f0be078ff3672c35c468ed35738f1;hb=HEAD
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  include/c.h    |    8 +++
>  include/list.h |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+), 0 deletions(-)
> 
> diff --git a/include/c.h b/include/c.h
> index c4a95aa..290303e 100644
> --- a/include/c.h
> +++ b/include/c.h
> @@ -104,6 +104,14 @@
>  	_max1 > _max2 ? _max1 : _max2; })
>  #endif
>  
> +#ifndef offsetof
> +#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> +#endif
> +
> +#define container_of(ptr, type, member) ({                      \
> +			const typeof( ((type *)0)->member ) *__mptr = (ptr); \
> +			(type *)( (char *)__mptr - offsetof(type,member) );})
> +
>  #ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
>  # ifdef HAVE___PROGNAME
>  extern char *__progname;
> diff --git a/include/list.h b/include/list.h
> index f7b17fe..afcfeeb 100644
> --- a/include/list.h
> +++ b/include/list.h
> @@ -3,6 +3,7 @@
>   * Copyright (C) 1999-2008 by Theodore Ts'o
>   *
>   * (based on list.h from e2fsprogs)
> + * Merge sort based on kernel's implementation.
>   */
>  
>  #ifndef UTIL_LINUX_LIST_H
> @@ -192,6 +193,137 @@ _INLINE_ void list_splice(struct list_head *list, struct list_head *head)
>  	for (pos = (head)->next, pnext = pos->next; pos != (head); \
>  	     pos = pnext, pnext = pos->next)
>  
> +#define MAX_LIST_LENGTH_BITS 20
> +
> +/*
> + * Returns a list organized in an intermediate format suited
> + * to chaining of merge() calls: null-terminated, no reserved or
> + * sentinel head node, "prev" links not maintained.
> + */
> +static struct list_head *merge(int (*cmp)(struct list_head *a,
> +					  struct list_head *b),
> +			       struct list_head *a, struct list_head *b)
> +{
> +	struct list_head head, *tail = &head;
> +
> +	while (a && b) {
> +		/* if equal, take 'a' -- important for sort stability */
> +		if ((*cmp)(a, b) <= 0) {
> +			tail->next = a;
> +			a = a->next;
> +		} else {
> +			tail->next = b;
> +			b = b->next;
> +		}
> +		tail = tail->next;
> +	}
> +	tail->next = a?:b;
> +	return head.next;
> +}
> +
> +/*
> + * Combine final list merge with restoration of standard doubly-linked
> + * list structure.  This approach duplicates code from merge(), but
> + * runs faster than the tidier alternatives of either a separate final
> + * prev-link restoration pass, or maintaining the prev links
> + * throughout.
> + */
> +static void merge_and_restore_back_links(int (*cmp)(struct list_head *a,
> +						    struct list_head *b),
> +					 struct list_head *head,
> +					 struct list_head *a, struct list_head *b)
> +{
> +	struct list_head *tail = head;
> +
> +	while (a && b) {
> +		/* if equal, take 'a' -- important for sort stability */
> +		if ((*cmp)(a, b) <= 0) {
> +			tail->next = a;
> +			a->prev = tail;
> +			a = a->next;
> +		} else {
> +			tail->next = b;
> +			b->prev = tail;
> +			b = b->next;
> +		}
> +		tail = tail->next;
> +	}
> +	tail->next = a ? : b;
> +
> +	do {
> +		/*
> +		 * In worst cases this loop may run many iterations.
> +		 * Continue callbacks to the client even though no
> +		 * element comparison is needed, so the client's cmp()
> +		 * routine can invoke cond_resched() periodically.
> +		 */
> +		(*cmp)(tail->next, tail->next);
> +
> +		tail->next->prev = tail;
> +		tail = tail->next;
> +	} while (tail->next);
> +
> +	tail->next = head;
> +	head->prev = tail;
> +}
> +
> +
> +/**
> + * list_sort - sort a list
> + * @head: the list to sort
> + * @cmp: the elements comparison function
> + *
> + * This function implements "merge sort", which has O(nlog(n))
> + * complexity.
> + *
> + * The comparison function @cmp must return a negative value if @a
> + * should sort before @b, and a positive value if @a should sort after
> + * @b. If @a and @b are equivalent, and their original relative
> + * ordering is to be preserved, @cmp must return 0.
> + */
> +_INLINE_ void list_sort(struct list_head *head,
> +			int (*cmp)(struct list_head *a,
> +				   struct list_head *b))
> +{
> +	struct list_head *part[MAX_LIST_LENGTH_BITS+1]; /* sorted partial lists
> +							   -- last slot is a sentinel */
> +	int lev;  /* index into part[] */
> +	int max_lev = 0;
> +	struct list_head *list;
> +
> +	if (list_empty(head))
> +		return;
> +
> +	memset(part, 0, sizeof(part));
> +
> +	head->prev->next = NULL;
> +	list = head->next;
> +
> +	while (list) {
> +		struct list_head *cur = list;
> +		list = list->next;
> +		cur->next = NULL;
> +
> +		for (lev = 0; part[lev]; lev++) {
> +			cur = merge(cmp, part[lev], cur);
> +			part[lev] = NULL;
> +		}
> +		if (lev > max_lev) {
> +			/* list passed to list_sort() too long for efficiency */
> +			if (lev >= ARRAY_SIZE(part)-1)
> +				lev--;
> +			max_lev = lev;
> +		}
> +		part[lev] = cur;
> +	}
> +
> +	for (lev = 0; lev < max_lev; lev++)
> +		if (part[lev])
> +			list = merge(cmp, part[lev], list);
> +
> +	merge_and_restore_back_links(cmp, head, part[max_lev], list);
> +}
> +
>  #undef _INLINE_
>  
>  #endif /* UTIL_LINUX_LIST_H */
