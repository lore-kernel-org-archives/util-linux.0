Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:39:39 +0100 (BST)
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/17] eject: add struct eject_control to remove global
 variables
In-Reply-To: <20140912092604.GV21325@x2.net.home>
Message-ID: <alpine.LNX.2.03.1409162137590.3712@kerolasa-home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi> <1410093785-17537-13-git-send-email-kerolasa@iki.fi> <20140912092604.GV21325@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Fri, 12 Sep 2014, Karel Zak wrote:

> On Sun, Sep 07, 2014 at 01:43:00PM +0100, Sami Kerola wrote:
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  sys-utils/eject.c | 394 +++++++++++++++++++++++++++---------------------------
>>  1 file changed, 198 insertions(+), 196 deletions(-)
>>
>> diff --git a/sys-utils/eject.c b/sys-utils/eject.c
>> index 03744c7..767ede7 100644
>> --- a/sys-utils/eject.c
>> +++ b/sys-utils/eject.c
>> @@ -81,31 +81,34 @@ static const char * const hotplug_subsystems[] = {
>>  	"ccw"
>>  };
>>
>> -/* Global Variables */
>> -static int a_option; /* command flags and arguments */
>> -static int c_option;
>> -static int d_option;
>> -static int f_option;
>> -static int F_option;
>> -static int n_option;
>> -static int q_option;
>> -static int r_option;
>> -static int s_option;
>> -static int t_option;
>> -static int T_option;
>> -static int X_option;
>> -static int v_option;
>> -static int x_option;
>> -static int p_option;
>> -static int m_option;
>> -static int M_option;
>> -static int i_option;
>> -static int a_arg;
>> -static int i_arg;
>> -static long int c_arg;
>> -static long int x_arg;
>> -
>> -struct libmnt_table *mtab;
>> +struct eject_control {
>> +	struct libmnt_table *mtab;
>> +	char *device;			/* device or mount point to be ejected */
>> +	int fd;				/* file descriptor for device */
>> +	uint32_t 			/* command flags and arguments */
>
> Again, don't be creative, use "unsigned int". The reality is that
> you have zero control on the way how compiler pack the bits.

Corrected version is easiest to get from my github branch misc. I will 
send update to pull request shortly.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
