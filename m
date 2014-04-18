Return-Path: coreutils-bounces+kzak=redhat.com@gnu.org
Message-ID: <535130F5.3030700@linux.vnet.ibm.com>
Date: Fri, 18 Apr 2014 19:34:37 +0530
From: Janani Venkataraman <jananive@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pavel Emelyanov <xemul@parallels.com>
Subject: Re: [PATCH 04/33] Hold threads
References: <20140320093040.14878.903.stgit@localhost.localdomain>
	<20140320093931.14878.89112.stgit@localhost.localdomain>
	<532B3B00.6080201@parallels.com>
In-Reply-To: <532B3B00.6080201@parallels.com>
Content-Type: multipart/alternative;
	boundary="------------080202060001000902020106"
Cc: amwang@redhat.com, procps@freelists.org, oleg@redhat.com,
        rdunlap@xenotime.net, tarundsk@linux.vnet.ibm.com,
        aravinda@linux.vnet.ibm.com, hch@lst.de, mhiramat@redhat.com,
        jeremy.fitzhardinge@citrix.com, suzuki@linux.vnet.ibm.com,
        coreutils@gnu.org, kosaki.motohiro@jp.fujitsu.com, adobriyan@gmail.com,
        util-linux@vger.kernel.org, james.hogan@imgtec.com,
        roland@hack.frob.com, ananth@linux.vnet.ibm.com, gorcunov@openvz.org,
        avagin@openvz.org, linux-kernel@vger.kernel.org, eparis@redhat.com,
        d.hatayama@jp.fujitsu.com, andi@firstfloor.org, tj@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Unsubscribe: <https://lists.gnu.org/mailman/options/coreutils>,
	<mailto:coreutils-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/coreutils>
List-Post: <mailto:coreutils@gnu.org>
List-Help: <mailto:coreutils-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/coreutils>,
	<mailto:coreutils-request@gnu.org?subject=subscribe>
Errors-To: coreutils-bounces+kzak=redhat.com@gnu.org
Sender: coreutils-bounces+kzak=redhat.com@gnu.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080202060001000902020106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/21/2014 12:31 AM, Pavel Emelyanov wrote:
> On 03/20/2014 01:39 PM, Janani Venkataraman wrote:
>> Getting number of threads and their respective IDs through /proc/pid/stat and
>> /proc/pid/task.
>>
>> The threads are then seized and interrupted. After the dump is taken they are
>> detached.
>>
>> Signed-off-by: Janani Venkataraman <jananive@linux.vnet.ibm.com>
>> ---
>> +/* Gets the Thread IDS and siezes them */
>> +int seize_threads(int pid)
>> +{
>> +	char filename[40];
>> +	DIR *dir;
>> +	int ct = 0, ret = 0, tmp_tid;
>> +	struct dirent *entry;
>> +	char state;
>> +
>> +	ret = get_thread_count(pid);
>> +	if (ret == -1)
>> +		return -1;
>> +
>> +	cp.thread_count = ret;
>> +	cp.t_id = calloc(cp.thread_count, sizeof(int));
>> +	if (!cp.t_id) {
>> +		status = errno;
>> +		gencore_log("Could not allocate memory for thread_ids.\n");
>> +		return -1;
>> +	}
>> +
>> +	snprintf(filename, 40, "/proc/%d/task", pid);
>> +	dir = opendir(filename);
>> +
>> +	while ((entry = readdir(dir))) {
> This simple loop is not enough -- threads may appear and disappear while
> you do the readdir and seize, so you should scan it several times to
> make sure you caught all the threads.
>
> You can look at how this is done in CRIU in cr-dump,c:collect_threads().
>
If there are any new threads generated after the process is
issued a gencore, we need to ensure even those threads are
captured and seized. Hence we read the /proc/pid/task, till
no new threads are created.

We do a readdir again and again, till we find no new threads.
If a new thread is found, it is inserted in the right position.
This process is repeated till readdir reads no new threads.

Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
Signed-off-by: Janani Venkataraman<jananive@linux.vnet.ibm.com>
---
  src/coredump.c |  161 +++++++++++++++++++++++++++++++++++++++++---------------
  1 file changed, 117 insertions(+), 44 deletions(-)

diff --git a/src/coredump.c b/src/coredump.c
index 49af7b3..2247ba2 100644
--- a/src/coredump.c
+++ b/src/coredump.c
@@ -93,68 +93,141 @@ void init_core(void)
  	memset(&cp, 0, sizeof(struct core_proc));
  }

-/* Gets the Thread IDS and siezes them */
-int seize_threads(int pid)
+/* Check if a particular TID is already added to cp.t_id */
+int search(int pid, int n)
  {
-	char filename[40];
-	DIR *dir;
-	int ct = 0, ret = 0, tmp_tid;
-	struct dirent *entry;
-	char state;
+	int first, last, middle;
+
+	first = 0;
+	last = n - 1;
+
+	while( first <= last ) {
+		
+		middle = (first + last)/2;
+
+		if ( cp.t_id[middle] < pid )
+			first = middle + 1;
+		else if ( cp.t_id[middle] == pid )
+			return 1;
+		else
+			last = middle - 1;
+	}

-	ret = get_thread_count(pid);
-	if (ret == -1)
-		return -1;
+	return 0;
+}

-	cp.thread_count = ret;
-	cp.t_id = calloc(cp.thread_count, sizeof(int));
-	if (!cp.t_id) {
-		status = errno;
-		gencore_log("Could not allocate memory for thread_ids.\n");
-		return -1;
+/* Insert a TID to cp.t_id */
+void insert (int tid, int n)
+{
+	int i, j, flag = 0;
+
+	for (i = 0; (i < n) && (tid > cp.t_id[i]); i++);
+
+	j = i;
+	while (j < n) {
+		cp.t_id[j + 1] = cp.t_id[j];
+		j++;
  	}

+	cp.t_id[i] = tid;
+}
+
+/*
+ * Read the directory /proc/pid/task again and again
+ * till we find no new threads.
+ */
+int scan_threads(int pid)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int tmp_tid, ret = 0, k = 0;
+	char state;
+	char filename[40];
+
  	snprintf(filename, 40, "/proc/%d/task", pid);
+	
  	dir = opendir(filename);

  	while ((entry = readdir(dir))) {
  		if (entry->d_type == DT_DIR && entry->d_name[0] != '.') {
  			tmp_tid = atoi(entry->d_name);
-			ret = ptrace(PTRACE_SEIZE, tmp_tid, 0, 0);
-			if (ret) {
-				state = get_thread_status(tmp_tid);
-				if (state == 'Z')
-					goto assign;
-				status = errno;
-				gencore_log("Could not seize thread: %d\n",
-								tmp_tid);
-				break;
-			}
-			ret = ptrace(PTRACE_INTERRUPT, tmp_tid, 0, 0);
-			if (ret) {
-				state = get_thread_status(tmp_tid);
-				if (state == 'Z')
-					goto assign;
-				status = errno;
-				gencore_log("Could not interrupt thread: %d\n",
-								tmp_tid);
-				break;
-			}
-assign:
-			/* If a new thread, is created after we fetch the thread_count,
-			 * we may encounter a buffer overflow situation in the cp_tid.
-			 * Hence we check this case and re-allocate memory if required.
+			/*
+			 * Search for the thread, if not present, seize, interrupt
+			 * and insert it in cp.t_id.
  			 */
-			cp.t_id[ct++] = tmp_tid;
+			if (!search(tmp_tid, cp.thread_count)) {
+
+				k++;
+
+				ret = ptrace(PTRACE_SEIZE, tmp_tid, 0, 0);
+				if (ret) {
+					state = get_thread_status(tmp_tid);
+					if (state == 'Z')
+						goto assign;
+					status = errno;
+					gencore_log("Could not seize thread: %d\n",
+							tmp_tid);
+					break;
+				}
+
+				ret = ptrace(PTRACE_INTERRUPT, tmp_tid, 0, 0);
+				if (ret) {
+					state = get_thread_status(tmp_tid);
+					if (state == 'Z')
+						goto assign;
+					status = errno;
+					gencore_log("Could not interrupt thread: %d\n",
+							tmp_tid);
+					break;
+				}
+assign:
+				cp.t_id = (char *) realloc(cp.t_id, (cp.thread_count + 1) * sizeof(int));
+				if (!cp.t_id) {
+					status = errno;
+					gencore_log("Could not allocate memory for thread_ids.\n");
+					return -1;
+				}
+
+				insert(tmp_tid, cp.thread_count);
+				cp.thread_count ++;
+			}
  		}
  	}

-	/* Reassigning based on successful seizes */
-	cp.thread_count = ct;
-
  	closedir(dir);

+	if (!k)
+		return 1;
+
+	return ret;
+}
+
+/* Gets the Thread IDS and siezes them */
+int seize_threads(int pid)
+{
+	int ret = 0;
+
+	cp.thread_count = 0;
+	cp.t_id = calloc(cp.thread_count, sizeof(int));
+	if (!cp.t_id) {
+		status = errno;
+		gencore_log("Could not allocate memory for thread_ids.\n");
+		return -1;
+	}
+
+	/*
+	 * Read the directory /proc/pid/task again and again
+	 * till we find no new threads.
+	 */
+
+	do {
+		ret = scan_threads(pid);
+	} while (ret == 0);
+
  	/* Successful seize and interrupt on all threads makes ret = 0 */
+	if (ret == 1)
+		return 0;
+
  	return ret;
  }


Thanks.
Janani


--------------080202060001000902020106
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <tt><br>
    </tt>
    <div class="moz-cite-prefix"><tt>On 03/21/2014 12:31 AM, Pavel
        Emelyanov wrote:</tt><tt><br>
      </tt></div>
    <blockquote cite="mid:532B3B00.6080201@parallels.com" type="cite">
      <pre wrap="">On 03/20/2014 01:39 PM, Janani Venkataraman wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Getting number of threads and their respective IDs through /proc/pid/stat and
/proc/pid/task.

The threads are then seized and interrupted. After the dump is taken they are
detached.

Signed-off-by: Janani Venkataraman <a class="moz-txt-link-rfc2396E" href="mailto:jananive@linux.vnet.ibm.com">&lt;jananive@linux.vnet.ibm.com&gt;</a>
---
</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">+/* Gets the Thread IDS and siezes them */
+int seize_threads(int pid)
+{
+	char filename[40];
+	DIR *dir;
+	int ct = 0, ret = 0, tmp_tid;
+	struct dirent *entry;
+	char state;
+
+	ret = get_thread_count(pid);
+	if (ret == -1)
+		return -1;
+
+	cp.thread_count = ret;
+	cp.t_id = calloc(cp.thread_count, sizeof(int));
+	if (!cp.t_id) {
+		status = errno;
+		gencore_log("Could not allocate memory for thread_ids.\n");
+		return -1;
+	}
+
+	snprintf(filename, 40, "/proc/%d/task", pid);
+	dir = opendir(filename);
+
+	while ((entry = readdir(dir))) {
</pre>
      </blockquote>
      <pre wrap="">
This simple loop is not enough -- threads may appear and disappear while
you do the readdir and seize, so you should scan it several times to
make sure you caught all the threads.

You can look at how this is done in CRIU in cr-dump,c:collect_threads().
<tt>
</tt></pre>
    </blockquote>
    <pre wrap="">If there are any new threads generated after the process is
issued a gencore, we need to ensure even those threads are
captured and seized. Hence we read the /proc/pid/task, till
no new threads are created.

We do a readdir again and again, till we find no new threads.
If a new thread is found, it is inserted in the right position.
This process is repeated till readdir reads no new threads.

Signed-off-by: Suzuki K. Poulose <a class="moz-txt-link-rfc2396E" href="mailto:suzuki@in.ibm.com">&lt;suzuki@in.ibm.com&gt;</a>
Signed-off-by: Janani Venkataraman <a class="moz-txt-link-rfc2396E" href="mailto:jananive@linux.vnet.ibm.com">&lt;jananive@linux.vnet.ibm.com&gt;</a>
---
 src/coredump.c |  161 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 117 insertions(+), 44 deletions(-)

diff --git a/src/coredump.c b/src/coredump.c
index 49af7b3..2247ba2 100644
--- a/src/coredump.c
+++ b/src/coredump.c
@@ -93,68 +93,141 @@ void init_core(void)
 	memset(&amp;cp, 0, sizeof(struct core_proc));
 }

-/* Gets the Thread IDS and siezes them */
-int seize_threads(int pid)
+/* Check if a particular TID is already added to cp.t_id */
+int search(int pid, int n)
 {
-	char filename[40];
-	DIR *dir;
-	int ct = 0, ret = 0, tmp_tid;
-	struct dirent *entry;
-	char state;
+	int first, last, middle;
+
+	first = 0;
+	last = n - 1;
+ 
+	while( first &lt;= last ) {
+		
+		middle = (first + last)/2;
+
+		if ( cp.t_id[middle] &lt; pid )
+			first = middle + 1;    
+		else if ( cp.t_id[middle] == pid )
+			return 1;
+		else
+			last = middle - 1;
+	}

-	ret = get_thread_count(pid);
-	if (ret == -1)
-		return -1;
+	return 0;
+}

-	cp.thread_count = ret;
-	cp.t_id = calloc(cp.thread_count, sizeof(int));
-	if (!cp.t_id) {
-		status = errno;
-		gencore_log("Could not allocate memory for thread_ids.\n");
-		return -1;
+/* Insert a TID to cp.t_id */
+void insert (int tid, int n)
+{
+	int i, j, flag = 0;
+
+	for (i = 0; (i &lt; n) &amp;&amp; (tid &gt; cp.t_id[i]); i++);
+
+	j = i;
+	while (j &lt; n) {
+		cp.t_id[j + 1] = cp.t_id[j];
+		j++;
 	}

+	cp.t_id[i] = tid;
+}
+
+/* 
+ * Read the directory /proc/pid/task again and again
+ * till we find no new threads.
+ */
+int scan_threads(int pid)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int tmp_tid, ret = 0, k = 0;
+	char state;
+	char filename[40];
+
 	snprintf(filename, 40, "<i class="moz-txt-slash"><span class="moz-txt-tag">/</span>proc<span class="moz-txt-tag">/</span></i>%d/task", pid);
+	
 	dir = opendir(filename);

 	while ((entry = readdir(dir))) {
 		if (entry-&gt;d_type == DT_DIR &amp;&amp; entry-&gt;d_name[0] != '.') {
 			tmp_tid = atoi(entry-&gt;d_name);
-			ret = ptrace(PTRACE_SEIZE, tmp_tid, 0, 0);
-			if (ret) {
-				state = get_thread_status(tmp_tid);
-				if (state == 'Z')
-					goto assign;
-				status = errno;
-				gencore_log("Could not seize thread: %d\n",
-								tmp_tid);
-				break;
-			}
-			ret = ptrace(PTRACE_INTERRUPT, tmp_tid, 0, 0);
-			if (ret) {
-				state = get_thread_status(tmp_tid);
-				if (state == 'Z')
-					goto assign;
-				status = errno;
-				gencore_log("Could not interrupt thread: %d\n",
-								tmp_tid);
-				break;
-			}
-assign:
-			/* If a new thread, is created after we fetch the thread_count,
-			 * we may encounter a buffer overflow situation in the cp_tid.
-			 * Hence we check this case and re-allocate memory if required.
+			/*
+			 * Search for the thread, if not present, seize, interrupt
+			 * and insert it in cp.t_id.
 			 */
-			cp.t_id[ct++] = tmp_tid;
+			if (!search(tmp_tid, cp.thread_count)) {
+
+				k++;
+
+				ret = ptrace(PTRACE_SEIZE, tmp_tid, 0, 0);
+				if (ret) {
+					state = get_thread_status(tmp_tid);
+					if (state == 'Z')
+						goto assign;
+					status = errno;
+					gencore_log("Could not seize thread: %d\n",
+							tmp_tid);
+					break;
+				}
+
+				ret = ptrace(PTRACE_INTERRUPT, tmp_tid, 0, 0);
+				if (ret) {
+					state = get_thread_status(tmp_tid);
+					if (state == 'Z')
+						goto assign;
+					status = errno;
+					gencore_log("Could not interrupt thread: %d\n",
+							tmp_tid);
+					break;
+				}
+assign:
+				cp.t_id = (char *) realloc(cp.t_id, (cp.thread_count + 1) * sizeof(int));
+				if (!cp.t_id) {
+					status = errno;
+					gencore_log("Could not allocate memory for thread_ids.\n");
+					return -1;
+				}
+
+				insert(tmp_tid, cp.thread_count);
+				cp.thread_count ++;
+			}
 		}
 	}

-	/* Reassigning based on successful seizes */
-	cp.thread_count = ct;
-
 	closedir(dir);

+	if (!k)
+		return 1;
+
+	return ret;
+}
+
+/* Gets the Thread IDS and siezes them */
+int seize_threads(int pid)
+{
+	int ret = 0;
+
+	cp.thread_count = 0;
+	cp.t_id = calloc(cp.thread_count, sizeof(int));
+	if (!cp.t_id) {
+		status = errno;
+		gencore_log("Could not allocate memory for thread_ids.\n");
+		return -1;
+	}
+
+	/* 
+	 * Read the directory /proc/pid/task again and again
+	 * till we find no new threads.
+	 */
+
+	do {
+		ret = scan_threads(pid);
+	} while (ret == 0);
+
 	/* Successful seize and interrupt on all threads makes ret = 0 */
+	if (ret == 1)
+		return 0;
+
 	return ret;
 }


Thanks.
Janani
</pre>
  </body>
</html>

--------------080202060001000902020106--
