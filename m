Return-Path: shakursmullick@gmail.com
Message-ID: <53710343.4000204@gmail.com>
Date: Mon, 12 May 2014 23:22:11 +0600
From: shams <shakursmullick@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 7/8] libsmartcols/src/table_print.c: sort the list
 before printing
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com> <1399796438-5495-7-git-send-email-shakursmullick@gmail.com> <20140512124347.GK8951@x2.net.home>
In-Reply-To: <20140512124347.GK8951@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

>  I guess that we need something like cl->compare_data.
>
>
>> +		cl = scols_table_get_key_column(tb);
>
>  Do we really need table->cl_key? Maybe it would be better to add
>
>    scols_sort_table(tb, cl)
>
Ok. I will submit v3 for this and related patches.
On 05/12/2014 06:43 PM, Karel Zak wrote:
> On Sun, May 11, 2014 at 02:20:37PM +0600, Shakur Shams Mullick wrote:
>> +int comparison_func(struct list_head *a, struct list_head *b, void *data)
>> +{
>> +	struct libscols_column *cl;
>> +	struct libscols_line *ra, *rb;
>> +	struct libscols_cell *ca, *cb;
>> +	
>> +	cl = (struct libscols_column *)(data);
>> +	
>> +	ra = list_entry(a, struct libscols_line, ln_lines);
>> +	rb = list_entry(b, struct libscols_line, ln_lines);
>> +	
>> +	ca = scols_line_get_cell(ra, cl->seqnum);
>> +	cb = scols_line_get_cell(rb, cl->seqnum);
>> +
>> +	return cl->compar(ca, cb, NULL);
>                              ^^^^^
> 
>  I guess that we need something like cl->compare_data.
> 
> 
>> +		cl = scols_table_get_key_column(tb);
> 
>  Do we really need table->cl_key? Maybe it would be better to add
> 
>    scols_sort_table(tb, cl)
> 
>  and keep control of the sort column in the applications. It will 
>  also allow to sort table by more columns.
> 
>     Karel
> 
> 
