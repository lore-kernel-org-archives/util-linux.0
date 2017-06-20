Return-Path: prvs=73440c47ac=vmagro@fb.com
Subject: Re: [PATCH] dmesg: fragment concatenation
To: Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>
References: <20170619214502.968882-1-vmagro@fb.com>
 <20170620093158.b3sgxw26ajwbh6s3@ws.net.home>
From: Vinnie Magro <vmagro@fb.com>
Message-ID: <eacf4553-78c1-08b9-a87e-6ef5ae6507dd@fb.com>
Date: Tue, 20 Jun 2017 10:57:59 -0700
MIME-Version: 1.0
In-Reply-To: <20170620093158.b3sgxw26ajwbh6s3@ws.net.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <util-linux.vger.kernel.org>

Extended console seems to be enabled only when the kernel is using 
netconsole.

Some more details on the extended console:
https://lkml.org/lkml/2015/4/29/347

On 6/20/17 2:31 AM, Karel Zak wrote:
> On Mon, Jun 19, 2017 at 02:45:02PM -0700, Vinnie Magro wrote:
>>   sys-utils/dmesg.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 111 insertions(+), 7 deletions(-)
> 
> Applied with minor changes, thanks.
> 
>> +	char		kmsg_saved[BUFSIZ];/* buffer to save line after fragment */
>> +	ssize_t		kmsg_read_buf;  /* if nonzero, read from kmsg_saved */
>                  ^^^^^^^^^^^^^
> 
> Renamed to kmsg_saved_size.
> 
> Is there any elegant way how I can test it? Frankly, I'm not sure what
> means "extended console" (it does not seem we have any kernel CONFIG_
> option for this).
> 
>      Karel
> 
