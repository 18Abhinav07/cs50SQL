# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

### Will the observations likely be evenly distributed across all boats, even if AquaByte most commonly collects observations between midnight and 1am? Why or why not?

The observations will be evenly distributed. Because each observation is randomly assigned to any one of the three boats, regardless of the time it was collected. Therefore, even though AquaByte most commonly collects observations between midnight and 1am, the observations will be evenly spread out among the boats.

### Suppose a researcher wants to query for all observations between midnight and 1am. On how many of the boats will they need to run the query?

The researcher will need to run the query on all of the boats. Since the observations are randomly assigned to any boat, each observation between midnight and 1am could be on any one of the three boats. Running the query on only one boat might miss observations stored on other boats.

### Reasons to adopt this approach:
- **Scalability**: Random partitioning allows AquaByte to distribute data among multiple boats, enabling scalability as more data is collected.
- **Load Balancing**: By distributing observations randomly, the load is evenly spread across all boats, preventing any single boat from becoming overwhelmed with data.

### Reasons not to adopt this approach:
- **Query Complexity**: Querying data requires searching across all boats, potentially increasing complexity and latency.
- **Data Locality**: Random partitioning doesn't ensure that related data is stored together, which might affect certain analytical tasks negatively.

## Partitioning by Hour

### Will the observations likely be evenly distributed across all boats, even if AquaByte most commonly collects observations between midnight and 1am? Why or why not?

The observations will not be evenly distributed. Since most observations are collected between midnight and 1am, Boat A, responsible for storing observations within this time range, will receive most of the observations.

### Suppose a researcher wants to query for all observations between midnight and 1am. On how many of the boats will they need to run the query?

The researcher will need to run the query on only some of the boats. Boat A will receive all observations between midnight and 1am, inclusive. Therefore, querying Boat A alone will suffice to retrieve all relevant observations.

### Reasons to adopt this approach:
- **Data Locality**: Observations are grouped by time, facilitating queries related to specific time ranges.
- **Simplicity**: Querying for data within a particular time range only requires accessing one boat, reducing query complexity.

### Reasons not to adopt this approach:
- **Skewed Distribution**: Depending on the time distribution of observations, certain boats may receive significantly more data than others, leading to potential load imbalance.
- **Limited Scalability**: This approach might not scale well if the distribution of observations across time shifts over time, leading to uneven data distribution among boats.

## Partitioning by Hash Value

### Will the observations likely be evenly distributed across all boats, even if AquaByte most commonly collects observations between midnight and 1am? Why or why not?

The observations will be evenly distributed. Since the hash function evenly distributes timestamps across all possible hash values, any single observation could be sent to any one of the three available boats, regardless of the time it was collected.

### Suppose a researcher wants to query for all observations between midnight and 1am. On how many of the boats will they need to run the query?

The researcher will likely need to run the query on all of the boats. Each observation in a range of observations could be assigned any arbitrary hash value, so the query would be best run on all boats to ensure retrieving all relevant observations.

### Suppose a researcher wants to query for a specific observation, which occurred at exactly 2023-11-01 00:00:01.020. On how many of the boats will they need to run the query?

The researcher will need to run the query on only some of the boats. Knowing the hash value of the specific timestamp allows the researcher to determine which boat stores the observation, minimizing the need to query all boats.



